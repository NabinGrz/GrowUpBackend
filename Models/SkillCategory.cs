using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class SkillCategory
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<Skill> Skills { get; set; }
    }
}
