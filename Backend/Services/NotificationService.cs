using FirebaseAdmin.Messaging;

namespace Backend.Services
{
    public class NotificationService
    {
        public async Task SendPushAsync(string token, string title, string body)
        {
            Console.WriteLine("SENDPUSH ÇALIŞTI");
            try
            {
                var message = new Message()
                {
                    Token = token,
                    Notification = new Notification
                    {
                        Title = title,
                        Body = body
                    }
                };

                var response = await FirebaseMessaging.DefaultInstance.SendAsync(message);

                Console.WriteLine("Firebase gönderildi: " + response);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Firebase HATA: " + ex.Message);
            }
        }
    }
}
   