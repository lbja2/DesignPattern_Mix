﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lbja2Test
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime dt = DateTime.Now;
            dt = dt.AddDays(201706030);
            Console.WriteLine(dt);
            Console.ReadKey();
        }
    }
}
