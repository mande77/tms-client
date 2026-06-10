tsc -outDir dist
node dist/index.js
cd tms-client
npx tsc -outDir dist
node dist/index.js
npx tsc -outDir dist
node dist/index.js
apk add nodejs npm
npm install @js-temporal/polyfill
npx tsc -outDir dist
npm install -g typescript
node dist/index.js
tsc -outDir dist
tsc -outDir dist
npm install -g typescript
npm install -g typescript
tsc -outDir dist
node dist/index.js
node dist/index.js
npm install @js-temporal/polyfill --save-prod
node dist/index.js
git init
apk add git
ls
cd tms-client
git init
cat << 'EOF' > .gitignore
node_modules/
dist/
*.js
*.js.map
*.d.ts
!src/**/*.d.ts
EOF

git add .
git status
git commit -m "feat: add TMS TypeScript data layer from M2"
git branch -M main
git remote add origin https://github.com/mande77/tms-client.git
git push -u origin main
git config --global user.email "የራስህ_ኢሜይል@gmail.com"
git config --global user.name "Mandefro"
git config --global user.email "mandefrobelete4556@gmail.com"
git config --global user.name "Mande77"git commit -m "feat: add TMS TypeScript data layer from M2"
git commit -m "feat: add TMS TypeScript data layer from M2"
git push -u origin main
git push -u origin main
npx tsc --noEmit
npm install -g ts-node typescript
cd MANDEFRO/tms-client
ls
cd storage/shared/MANDEFRO/tms-client
ts-node index.ts
find . -name "index.ts"
ts-node src/index.ts
export DOTNET_GCHeapHardLimit=0x10000000
export COMPlus_EnableDiagnostics=0
cd ~/TmsApi
dotnet run
curl -i http://localhost:5000/api/assessments/results
curl -i http://localhost:5000/api/assessments/results
dotnet --version
dotnet new webapi -n TmsApi --no-openapi --use-controllers
cd TmsApi
apk add dotnet-sdk
dotnet --version
apk add dotnet8-sdk
dotnet --version
rm -rf /var/cache/apk/*
apk update
apk add dotnet8-sdk
dotnet new webapi -n TmsApi --no-openapi --use-controllers
cd TmsApi
export DOTNET_GCHeapHardLimit=0x10000000
export COMPlus_EnableDiagnostics=0
dotnet new webapi -n TmsApi --no-openapi --use-controllers
cd TmsApi
find / -type d -name "tms-client" 2>/dev/null
mv ~/TmsApi /sdcard/Mandefro/
cd /sdcard/Mandefro/TmsApi
rm -rf /sdcard/Mandefro/TmsApi
cp -r ~/TmsApi /sdcard/Mandefro/
cd /sdcard/Mandefro/TmsApi
ls
cd ~/TmsApi
ls
cat << 'EOF' > TrainingAuthHandler.cs
using System.Security.Claims;
using System.Text.Encodings.Web;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;

public class TrainingAuthHandler : AuthenticationHandler<AuthenticationSchemeOptions>
{
    public TrainingAuthHandler(
        IOptionsMonitor<AuthenticationSchemeOptions> options,
        ILoggerFactory logger,
        UrlEncoder encoder)
        : base(options, logger, encoder)
    {
    }

    protected override Task<AuthenticateResult> HandleAuthenticateAsync()
    {
        if (!Request.Headers.ContainsKey("X-Training-User"))
        {
            return Task.FromResult(AuthenticateResult.Fail("Missing training user header."));
        }

        var claims = new[]
        {
            new Claim(ClaimTypes.Name, Request.Headers["X-Training-User"]!)
        };

        var identity = new ClaimsIdentity(claims, Scheme.Name);
        var principal = new ClaimsPrincipal(identity);
        var ticket = new AuthenticationTicket(principal, Scheme.Name);

        return Task.FromResult(AuthenticateResult.Success(ticket));
    }
}
EOF

cat << 'EOF' > Program.cs
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
EOF

dotnet run
