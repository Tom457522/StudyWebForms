using System.Collections.Generic;
using System.Linq;

namespace StudyWebForms
{
    public static class CourseRepository
    {
        public static List<Course> GetCourses()
        {
            return new List<Course>
            {
                new Course { Id = 1, Title = "Web Forms 基礎", Category = "WebForms", DurationMinutes = 30 },
                new Course { Id = 2, Title = "PostBack とイベント", Category = "WebForms", DurationMinutes = 30 },
                new Course { Id = 3, Title = "SQL Server 接続", Category = "Database", DurationMinutes = 45 },
                new Course { Id = 4, Title = "IIS とアプリケーションプール", Category = "Infrastructure", DurationMinutes = 45 }
            };
        }

        public static List<Course> Search(string keyword)
        {
            var courses = GetCourses();
            if (string.IsNullOrWhiteSpace(keyword))
            {
                return courses;
            }

            return courses
                .Where(x => x.Title.Contains(keyword) || x.Category.Contains(keyword))
                .ToList();
        }
    }
}
