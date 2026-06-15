using Backend.DTOs;
using Backend.Models;
using Microsoft.EntityFrameworkCore;

namespace Backend.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }
       
        
        //modeller için setler
        public DbSet<User> Users { get; set; }
        public DbSet<Bayi> Bayis { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Manager> Manager { get; set; }
        public DbSet<Building> Buildings { get; set; }
        public DbSet<Appointment> Appointments { get; set; }
        public DbSet<Video> Videos { get; set; }
        public DbSet<VideoProgres> VideoProgress {  get; set; }
        public DbSet<PaymentMethod> PaymentMethods { get; set; }
        public DbSet<Income> Incomes { get; set; }
        public DbSet<Expense> Expenses { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<UserToken> UserTokens { get; set; }



        // DBO için Setler
        public DbSet<ActiveAppointmentDto> ActiveAppointment { get; set; }
        public DbSet<YesterdayAppointmentDto> YesterdayAppointment { get; set; }
        public DbSet<FinanceReportDto> FinanceReport { get; set; }
        public DbSet<VideoReportDto> VideoReport { get; set; }
        public DbSet<AppointmentReportDto> AppointmentReport { get; set; } 
        public DbSet<CustomerReportDto> CustomerReports { get; set; }
        public DbSet<BayiReportDto> BayiReports { get; set; }
        public DbSet<LoginResponseDto> LoginResponses { get; set; }
        public DbSet<CustomerProfileDto> CustomerProfile { get; set; }
        public DbSet<BayiProfileDto> BayiProfile { get; set; }
        public DbSet<ManagerProfileDto> ManagerProfile { get; set; }
        public DbSet<DropDownBayiDto> DropDownBayi { get; set; }
        public DbSet<DropDownBuildingDto> DropDownBuilding { get; set; }
        public DbSet<DropDownCustomerDto> DropDownCustomer { get; set; }
        public DbSet<AppointmentResponseDto> AppointmentResponse { get; set; }
        public DbSet<UserResponseDto> UserResponse { get; set; }
        public DbSet<BayiResponseDto> BayiResponse { get; set; }
        public DbSet<VideoListDto> VideoList { get; set; }
        public DbSet<VideoDetailsResponseDto> VideoDetailsResponse { get; set; }
        public DbSet<BuildingListResponseDto> BuildingListResponse { get; set; }
        public DbSet<FinanceListRequestDto> FinanceListRequest { get; set; }
        public DbSet<CustomerListResponseDto> CustomerResponse { get; set; }
    }
}
