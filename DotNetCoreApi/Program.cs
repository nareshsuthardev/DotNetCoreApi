using DotNetCoreApi.Context;

var builder = WebApplication.CreateBuilder(args);
// Add services to the container.

builder.Services.AddSingleton<DapperContext>();/*
builder.Services.AddScoped<RoleController>();*/
builder.Services.AddControllers(options => options.SuppressImplicitRequiredAttributeForNonNullableReferenceTypes = true);
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddCors();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors(
    options =>
    {
        options.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    }
    );
app.UseAuthorization();

app.MapControllers();

app.Run();
