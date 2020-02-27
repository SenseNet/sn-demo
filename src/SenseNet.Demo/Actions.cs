using System;
using SenseNet.ApplicationModel;
using SenseNet.ContentRepository;
using SenseNet.ContentRepository.Storage.Security;

namespace SenseNet.Demo
{
    public static class Actions
    {
        [ODataAction]
        public static Content RegisterUser(Content content, string username, string email, string password)
        {
            if (string.IsNullOrEmpty(username))
                throw new ArgumentNullException(nameof(username));
            if (string.IsNullOrEmpty(email))
                throw new ArgumentNullException(nameof(email));
            if (string.IsNullOrEmpty(password))
                throw new ArgumentNullException(nameof(password));

            using (new SystemAccount())
            {
                //TODO: determine custom user content type
                var user = Content.CreateNew("User", content.ContentHandler, username);
                user["LoginName"] = username;
                user["Email"] = email;
                user["Enabled"] = true;
                user["Password"] = password;
                user.Save();

                return user;
            }
        }
    }
}
