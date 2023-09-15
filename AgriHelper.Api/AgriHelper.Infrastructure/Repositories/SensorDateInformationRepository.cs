using AgriHelper.Application.Contracts.Persistance;
using AgriHelper.Core.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Infrastructure.Repositories
{
    public class SensorDateInformationRepository: GenericRepository<SensorDateInformation>, ISensorDateInformationRepository
    {
        private readonly AgriHelperDbContext _context;

        public SensorDateInformationRepository(AgriHelperDbContext context): base(context)
        {
            _context = context;
        }

        public async Task<SensorDateInformation?> GetBySensorIdAndDate(int sensorId, DateTime date)
        {
            return await _context.SensorDateInformations.Where(a => a.SensorId == sensorId && a.DateTime == date).FirstOrDefaultAsync();
        }

        public async Task<List<SensorDateInformation>> GetSensorInformation(int sensorId, DateTime? resetDate, DateTime? tillDate = null)
        {
            if (resetDate == null)
            {
                return await _context.SensorDateInformations.Where(a => a.SensorId == sensorId).ToListAsync();

            }
            var query = _context.SensorDateInformations.Where(a => a.SensorId == sensorId && a.DateTime >= resetDate);
            if (tillDate == null)
            {
                return await query.ToListAsync();
            }
            return await query
                .Where(b => b.DateTime <= tillDate)
                .ToListAsync();
        }
    }
}
