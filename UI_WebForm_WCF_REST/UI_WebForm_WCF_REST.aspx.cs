using Newtonsoft.Json;
using System;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

public partial class _UI_WebForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        pnInput.Visible = true;
        pnHTML.Visible = false;

        if (IsPostBack)
        {
            pnInput.Visible = false;
            pnHTML.Visible = true;

            string action = Request.Form["action"];
            if (action == "submit")
            {
                string method = Request.Form["radio1"];
                string postData = Request.Form["PostData"];
                string targetURL = Request.Form["TargetURL"];
                string Headers = Request.Form["httpHeader"];
                
                lblURL.Text = targetURL;
                if (targetURL.Length > 0)
                {
                    txtResult.Text = RESTful_Service(method, targetURL, postData, Headers).Result;
                }
                else
                    txtResult.Text = "Invalid data";
            }
        }
    }

    // Install-Package System.Net.Http -Version 2.0.20710   - working for VS2010, VS2013
    public static async Task<string> RESTful_Service(string method, string endpoint, string postData, string Headers)
    {
        string content = "";
        string contentType = "";
        System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)192 | (SecurityProtocolType)768 | (SecurityProtocolType)3072;

        using( HttpClient client = new HttpClient() )
        {
            var message = new HttpRequestMessage(new HttpMethod(method), endpoint);

            string[] heads = Regex.Split(Headers, "\r\n");
            foreach (var item in heads)
            {
                string[] line = item.Split(':');
                if (line[0].ToLower().Contains("authorization"))
                    //message.Headers.Authorization = new AuthenticationHeaderValue("bearer", accessToken);
                    message.Headers.Authorization = new AuthenticationHeaderValue(line[1]);
                else if (line[0].ToLower().Contains("accept"))
                    //client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(line[1]));
                else if (line[0].ToLower().Contains("content-type"))
                    contentType = line[1].Split(';')[0];
            }

            try
            {
                HttpResponseMessage response = null;
                if (method.ToLower() == "get" || method.ToLower() == "delete")
                    response = await client.SendAsync(message);
                else if (postData.Length > 0)
                {
                    var Content = new StringContent(postData, Encoding.UTF8, "application/json");
                    if (method.ToLower() == "put")  response = await client.PutAsync(endpoint, Content);
                    if (method.ToLower() == "post") response = await client.PostAsync(endpoint, Content);
                }
                else
                {
                    content = "post data required";
                    return content;
                }

                response.EnsureSuccessStatusCode();
                if (response.IsSuccessStatusCode)
                {
                    HttpContent responseString = response.Content;
                    content = await responseString.ReadAsStringAsync();
                    content = WebUtility.HtmlDecode(content);

                    Console.WriteLine("Request Message Information:- \n\n" + response.RequestMessage + "\n");
                    Console.WriteLine("Response Message Header \n\n" + response.Content.Headers + "\n");
                }
                else
                    Console.WriteLine("{0} ({1})", (int)response.StatusCode, response.ReasonPhrase);
            }
            catch (Exception ex)
            {
                string errorType = ex.GetType().ToString();
                string errorMessage = errorType + ": " + ex.Message;
                //throw new Exception(errorMessage, ex.InnerException);
                content = errorMessage + ex.InnerException;
            }
            return content;
        }

    }


}