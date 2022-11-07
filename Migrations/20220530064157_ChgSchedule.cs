using Microsoft.EntityFrameworkCore.Migrations;

namespace Growup.Migrations
{
    public partial class ChgSchedule : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Schedule_AspNetUsers_ApplicationId",
                table: "Schedule");

            migrationBuilder.RenameColumn(
                name: "ApplicationId",
                table: "Schedule",
                newName: "ApplicationUserId");

            migrationBuilder.RenameIndex(
                name: "IX_Schedule_ApplicationId",
                table: "Schedule",
                newName: "IX_Schedule_ApplicationUserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Schedule_AspNetUsers_ApplicationUserId",
                table: "Schedule",
                column: "ApplicationUserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Schedule_AspNetUsers_ApplicationUserId",
                table: "Schedule");

            migrationBuilder.RenameColumn(
                name: "ApplicationUserId",
                table: "Schedule",
                newName: "ApplicationId");

            migrationBuilder.RenameIndex(
                name: "IX_Schedule_ApplicationUserId",
                table: "Schedule",
                newName: "IX_Schedule_ApplicationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Schedule_AspNetUsers_ApplicationId",
                table: "Schedule",
                column: "ApplicationId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
