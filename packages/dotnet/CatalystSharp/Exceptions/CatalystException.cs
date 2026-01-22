namespace CatalystSharp.Exceptions;

public class CatalystException : Exception
{
    public int? StatusCode { get; }
    public string? ResponseContent { get; }

    public CatalystException(string message) : base(message)
    {
    }

    public CatalystException(string message, int statusCode) : base(message)
    {
        StatusCode = statusCode;
    }

    public CatalystException(string message, int statusCode, string? responseContent) : base(message)
    {
        StatusCode = statusCode;
        ResponseContent = responseContent;
    }
}

public class BadRequestException : CatalystException
{
    public BadRequestException(string? responseContent = null)
        : base("Bad Request", 400, responseContent)
    {
    }
}

public class UnauthorizedException : CatalystException
{
    public UnauthorizedException(string? responseContent = null)
        : base("Unauthorized", 401, responseContent)
    {
    }
}

public class ForbiddenException : CatalystException
{
    public ForbiddenException(string? responseContent = null)
        : base("Forbidden", 403, responseContent)
    {
    }
}

public class NotFoundException : CatalystException
{
    public NotFoundException(string? responseContent = null)
        : base("Not Found", 404, responseContent)
    {
    }
}

public class ConflictException : CatalystException
{
    public ConflictException(string? responseContent = null)
        : base("Conflict", 409, responseContent)
    {
    }
}

public class InternalServerErrorException : CatalystException
{
    public InternalServerErrorException(string? responseContent = null)
        : base("Internal Server Error", 500, responseContent)
    {
    }
}
