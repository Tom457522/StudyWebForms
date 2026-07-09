using System;

namespace StudyWebForms.Chapters
{
    public partial class _07_DataBinding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        private void BindGrid()
        {
            CourseGridView.DataSource = CourseRepository.Search(KeywordTextBox.Text);
            CourseGridView.DataBind();
        }
    }
}
