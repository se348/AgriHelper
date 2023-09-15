using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Application.DTO.UserDTO;
using AgriHelper.Core.Models;
using AgriHelper.Infrastructure.Model;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Infrastructure
{
    public class DBInitializer: IDbInitializer
    {

        private readonly AgriHelperDbContext context;
        private readonly UserManager<ApplicationUser> _userManager;

        public DBInitializer(UserManager<ApplicationUser> userManager, AgriHelperDbContext context)
        {
            this.context = context;
            _userManager = userManager;
        }

        public async Task Initialize()
        {
            context.Database.EnsureCreated();

            if (context.Users.Any())
            {
                return;
            }
            var user1 = new User() { Name = "Semir Ahmed", Email ="semir2578@gmail.com", Phone="0984836744"};
            var user2 = new User() { Name = "Mekdes Abebe", Email = "mekdes@gmail.com", Phone = "0922825404" };

            var userPass1 = new ApplicationUser
            {
                Email = user1.Email,
                UserName = user1.Phone,
                EmailConfirmed = true
            };
           await _userManager.CreateAsync(userPass1, "Semir8483!");


            var userPass2 = new ApplicationUser
            {
                Email = user2.Email,
                UserName = user2.Phone,
                EmailConfirmed = true
            };
            await _userManager.CreateAsync(userPass2, "Semir8483!");


            await context.Users.AddRangeAsync(user1, user2);
            await context.SaveChangesAsync();

            var farm1 = new Farm() { City = "Addis Ababa", Country = "Ethiopia", Name = "My Farm in Addis", PostCode = "1000" };
            var farm2 = new Farm() { City = "Addis Ababa", Country = "Ethiopia", Name = "My second Farm", PostCode = "1000" };

            await context.AddRangeAsync(farm1, farm2);
            await context.SaveChangesAsync();

            var farmUser1 = new FarmUser() { FarmId = farm1.FarmId, UserId = user1.UserId };
            var farmUser2 = new FarmUser() { FarmId = farm2.FarmId, UserId = user2.UserId };

            await context.AddRangeAsync(farmUser1, farmUser2);

            var field1_1 = new Field() { Altitude = 127, FarmId = farm1.FarmId, Polygon="Field 1 1"};
            var field1_2 = new Field() { Altitude = 500, FarmId = farm1.FarmId, Polygon = "Field 1 2" };

            await context.AddRangeAsync(field1_1, field1_2 );
            await context.SaveChangesAsync();

            var sensor1_1_1 = new Sensor()
            {
                BatteryStatus = 1,
                CuttingDatCalculated = DateTime.Now.AddDays(35),
                FieldId = field1_1.FieldId,
                Latitude = 9.1451,
                Longitude = 40.489674,
                OptimalGDD = 455,
                State = 1,
                SensorNo = "4AB5C",
                BaseTemp = 15
            };

            var sensor1_1_2 = new Sensor()
            {
                BatteryStatus = 1,
                CuttingDatCalculated = DateTime.Now.AddDays(35),
                FieldId = field1_1.FieldId,
                Latitude = 9.1449,
                Longitude = 40.489672,
                OptimalGDD = 455,
                BaseTemp = 15,
                State = 1,
                SensorNo = "4AB5D"
            };

            var sensor1_1_3 = new Sensor()
            {
                BatteryStatus = 1,
                CuttingDatCalculated = DateTime.Now.AddDays(35),
                FieldId = field1_1.FieldId,
                Latitude = 9.1452,
                Longitude = 40.489673,
                OptimalGDD = 455,
                BaseTemp = 15,
                State = 1,
                SensorNo = "4AB5E"
            };

            var sensor1_1_4 = new Sensor()
            {
                BatteryStatus = 1,
                CuttingDatCalculated = DateTime.Now.AddDays(35),
                FieldId = field1_1.FieldId,
                Latitude = 9.1448,
                Longitude = 40.489669,
                OptimalGDD = 455,
                BaseTemp = 15,
                State = 1,
                SensorNo = "4AB5F"
            };

            await context.AddRangeAsync(sensor1_1_1, sensor1_1_2, sensor1_1_3, sensor1_1_4);
            await context.SaveChangesAsync();

        }
    }
}
