﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgriHelper.Application.Exceptions
{
    public class ConflictException: ApplicationException
    {
        public ConflictException(string message) : base(message)
        {
        }
    }
}
