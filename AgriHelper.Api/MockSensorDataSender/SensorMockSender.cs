using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;

namespace MockSensorDataSender
{
    public class SensorMockSender
    {
        [FunctionName("Function1")]
        public void Run([TimerTrigger("0 0 22 * * *")]TimerInfo myTimer, ILogger log)
        {
           
        }
    }
}
