using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Question
    {
        public int Id { get; set; }
        public int SkillId { get; set; }
        public Skill Skill { get; set; }
        public string Text { get; set; }

        public List<Option> Options { get; set; }
    }
}
