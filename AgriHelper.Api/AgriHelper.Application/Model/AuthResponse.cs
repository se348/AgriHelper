using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Model
{
    public class AuthResponse
    {
      
            public int UserId { get; set; }
            public string Phone { get; set; }
            public string Email { get; set; }
            public string Token { get; set; }
            
            public string Name { get; set; }
    }
}
