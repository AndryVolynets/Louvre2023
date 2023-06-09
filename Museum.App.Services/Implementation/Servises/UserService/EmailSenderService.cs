﻿using Museum.App.Services.Attributes;
using Museum.App.Services.Interfaces.Servises;

namespace Museum.App.Services.Implementation.Servises.Other
{
    [Service]
    public class EmailSenderService : IEmailSenderService
    {
        public Task SendEmailAsync(string email, string subject, string message)
        {
            return Task.CompletedTask;
        }
    }
}
