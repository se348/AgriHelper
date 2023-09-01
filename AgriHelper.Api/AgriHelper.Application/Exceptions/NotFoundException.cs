using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Exceptions
{
    public class NotFoundException: ApplicationException
    {
        public NotFoundException(string message) : base(message)
        {
        }
    }
}
