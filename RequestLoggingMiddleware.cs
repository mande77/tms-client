using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System;
using System.Threading.Tasks;

public class RequestLoggingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<RequestLoggingMiddleware> _logger;

    public RequestLoggingMiddleware(RequestDelegate next, ILogger<RequestLoggingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        // 1. ልዩ የ Correlation ID መፍጠር ወይም ከጥያቄው ሄደር ላይ መውሰድ
        if (!context.Request.Headers.TryGetValue("X-Correlation-Id", out var correlationId))
        {
            correlationId = Guid.NewGuid().ToString();
        }

        // 2. በምላሹ (Response) ላይ የ Correlation ID መጫን
        context.Response.Headers["X-Correlation-Id"] = correlationId;

        // 3. መረጃውን በኮንሶል ላይ ሎግ ማድረግ
        _logger.LogInformation("Handling request: {Method} {Path} [CorrelationID: {CorrelationId}]", 
            context.Request.Method, context.Request.Path, correlationId);

        // 4. ጥያቄውን ወደ ቀጣዩ ሚድልዌር ማስተላለፍ
        await _next(context);

        // 5. ጥያቄው ተጠናቆ ሲወጣ ሎግ ማድረግ
        _logger.LogInformation("Finished handling request with Status Code: {StatusCode} [CorrelationID: {CorrelationId}]", 
            context.Response.StatusCode, correlationId);
    }
}
