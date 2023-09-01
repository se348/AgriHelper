using AgriHelper.Application.Contracts.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Infrastructure.Common
{
    public class DateTimeProvider : IDateTimeProvider
    {
        public DateTime? DateUTCNow { get => DateTime.UtcNow; }
    }
}
