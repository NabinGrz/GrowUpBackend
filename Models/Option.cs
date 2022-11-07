using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Growup.Models
{
    public class Option
    {
        public int Id { get; set; }
        public string Text { get; set; }

        public int QuestionId { get; set; }
        public Question Question { get; set; }
        public bool IsCorrectOption { get; set; }
    }
}
