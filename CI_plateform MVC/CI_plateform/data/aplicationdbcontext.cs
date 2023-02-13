using Microsoft.EntityFrameworkCore;

namespace CI_plateform.data
{
    public class aplicationdbcontext : DbContext
    {
        public aplicationdbcontext(DbContextOptions<aplicationdbcontext> options): base(options)
        {

        }
        
    }
}
