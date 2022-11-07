using Microsoft.EntityFrameworkCore.Migrations;

namespace Growup.Migrations
{
    public partial class PopulateUserRole : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql("INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES('1', 'Admin', 'Admin', ' ' );");
            migrationBuilder.Sql("INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES('2', 'Teacher', 'Teacher', ' ');");
            migrationBuilder.Sql("INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES('3', 'Student','Student', ' ');");

        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
