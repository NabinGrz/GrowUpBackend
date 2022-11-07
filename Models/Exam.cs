using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Exam
    {
        public int Id { get; set; }
        public int SkillId { get; set; }
        public string Name { get; set; }
        public string Difficulty { get; set; }
        public string TutorName { get; set; }
        public int TotalQuestions { get; set; }

    }
}
