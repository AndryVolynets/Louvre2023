﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Museum.Models.TableModels
{
    public class Artists
    {
        public int ArtistId { get; set; }
        public string? FullName { get; set; }
        public DateTime BirthDate { get; set; }
        public DateTime DeathDate { get; set; }
        public string? Style { get; set; }
        public string? Genres { get; set; }
    }

}