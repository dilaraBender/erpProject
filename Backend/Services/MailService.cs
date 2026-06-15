using System.Net;
using System.Net.Mail;

public class EmailService
{
    public async Task SendEmail(string toEmail, string password)
    {
        var smtp = new SmtpClient("smtp.gmail.com")
        {
            Port = 587,
            Credentials = new NetworkCredential(
                "dilarabender4@gmail.com",
                "jnkcwwzmfrizmxdb"
            ),
            EnableSsl = true,
        };

        var mail = new MailMessage
        {
            From = new MailAddress("dilarabender4@gmail.com"),
            Subject = "Pata Technology | Hesap Oluşturuldu",
            Body =
         $"Sayın Kullanıcımız,\n\n" +

         $"Pata Technology uygulamasında hesabınız başarıyla oluşturulmuştur.\n\n" +

         $"Giriş işlemlerinizi gerçekleştirebilmeniz için geçici şifreniz aşağıda yer almaktadır:\n\n" +
         $"Geçici Şifre: {password}\n\n" +

         $"Güvenliğiniz için ilk girişinizde şifrenizi değiştirmeniz gerekmektedir.\n\n" +

         $"Herhangi bir sorun yaşamanız durumunda sistem yöneticiniz ile iletişime geçebilirsiniz.\n\n" +

         $"Saygılarımızla,\n" +
         $"Pata Technology Destek Ekibi"
        };

        mail.To.Add(toEmail);

        await smtp.SendMailAsync(mail);
    }
}