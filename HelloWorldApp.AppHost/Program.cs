var builder = DistributedApplication.CreateBuilder(args);

var apiService = builder.AddProject<Projects.HelloWorldApp_ApiService>("apiservice");

builder.AddProject<Projects.HelloWorldApp_Web>("webfrontend")
    .WithExternalHttpEndpoints()
    .WithReference(apiService);

builder.Build().Run();
