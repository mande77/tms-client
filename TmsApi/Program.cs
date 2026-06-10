using Microsoft.AspNetCore.Authentication;

var builder = WebApplication.CreateBuilder(args);

// 1. ሰርቪሶችን መመዝገብ (Register Services)
builder.Services.AddAuthentication("Training")
    .AddScheme<AuthenticationSchemeOptions, TrainingAuthHandler>("Training", null);
builder.Services.AddAuthorization();

var app = builder.Build();

// 2. የሚድልዌር ቅደም ተከተል (Middleware Pipeline)
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

// 3. የመጨረሻ ነጥብ እና ጥበቃ ማገናኘት (Map Endpoint & Protect)
app.MapGet("/api/assessments/results", () => Results.Ok(new
{
    courseCode = "CS-101",
    studentId = "S-001",
    letterGrade = "A"
})).RequireAuthorization();

app.Run();
