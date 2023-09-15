using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Contracts.Persistance
{
    public interface IDbInitializer
    {
        public Task Initialize();
    }
}
