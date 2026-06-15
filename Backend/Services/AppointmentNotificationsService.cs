using Backend.Data;
using Backend.Services;
using Microsoft.EntityFrameworkCore;

public class AppointmentReminderService : BackgroundService
{
    private readonly IServiceScopeFactory _scopeFactory;

    public AppointmentReminderService(IServiceScopeFactory scopeFactory)
    {
        _scopeFactory = scopeFactory;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            using (var scope = _scopeFactory.CreateScope())
            {
                var context = scope.ServiceProvider.GetRequiredService<AppDbContext>();
                var notificationService = scope.ServiceProvider.GetRequiredService<NotificationService>();

                var tomorrow = DateTime.Today.AddDays(1);

                var appointments = await context.Appointments
                    .Include(a => a.Bayi)
                    .Include(a => a.Buildings)
                    .Where(a => a.AppDate.Date == tomorrow.Date && a.Status != "cancelled")
                    .ToListAsync();

                foreach (var appointment in appointments)
                {
                    var customerToken = await context.UserTokens
                        .Where(x => x.UserId == appointment.Buildings.CustomerId)
                        .Select(x => x.Token)
                        .FirstOrDefaultAsync();

                    if (!string.IsNullOrEmpty(customerToken))
                    {
                        await notificationService.SendPushAsync(
                            customerToken,
                            "Randevu Hatırlatma",
                            $"Yarın saat {appointment.AppTime} randevunuz var."
                        );
                    }
                }
            }

            await Task.Delay(TimeSpan.FromHours(24), stoppingToken);
        }
    }
}