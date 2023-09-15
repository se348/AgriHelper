using AgriHelper.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Contracts.Persistance
{
    public interface ISensorDateInformationRepository: IGenericRepository<SensorDateInformation>
    {
        public Task<SensorDateInformation?> GetBySensorIdAndDate(int sensorId, DateTime date);

        public Task<List<SensorDateInformation>> GetSensorInformation(int sensorId, DateTime? resetDate, DateTime? tillDate=null);
    }
}
