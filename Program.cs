using Microsoft.AspNetCore.Authentication;

var builder = WebApplication.CreateBuilder(args);

// ሰርቪሶችን መመዝገብ
builder.Services.AddAuthentication("Training")
    .AddScheme<AuthenticationSchemeOptions, TrainingAuthHandler>("Training", null);
builder.Services.AddAuthorization();

var app = builder.Build();

// የጥያቄዎች ፍሰት መስመር (የሚድልዌር ቅደም ተከተል)
app.UseMiddleware<RequestLoggingMiddleware>(); // 1. መጀመሪያ ጥያቄውን መዝግብና መለያ ስጠው

app.UseRouting();                              // 2. የት መሄድ እንዳለበት መምራት
app.UseAuthentication();                       // 3. ማንነቱን ማረጋገጥ
app.UseAuthorization();                        // 4. ፈቃድ መፈተሽ

// የመጨረሻ ነጥብ
app.MapGet("/api/assessments/results", () => Results.Ok(new
{
    courseCode = "CS-101",
    studentId = "S-001",
    letterGrade = "A"
})).RequireAuthorization();

app.Run();
