using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Exceptions
{
    public class ServerErrorException: ApplicationException
    {
        public ServerErrorException(string message) : base(message)
        {
        }
    }
}
