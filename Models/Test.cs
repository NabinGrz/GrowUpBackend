using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Test
    {
        public int Id { get; set; }
        public string Question { get; set; }
        public int ExamID { get; set; }
        public Exam Exam { get; set; }
        public List<TestOptions> Options { get; set; }
    }
}
