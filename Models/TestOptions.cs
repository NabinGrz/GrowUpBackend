using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class TestOptions
    {
        public int Id { get; set; }
        public string Text { get; set; }
        public int TestID { get; set; }
        public Test Test { get; set; }
        public bool IsCorrectOption { get; set; }
    }
}
