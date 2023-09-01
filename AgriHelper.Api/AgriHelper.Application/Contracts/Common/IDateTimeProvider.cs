using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Contracts.Common
{
    public interface IDateTimeProvider
    {
        public DateTime? DateUTCNow{ get;}
    }
}
