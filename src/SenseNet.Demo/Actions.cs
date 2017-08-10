using System;
using SenseNet.ApplicationModel;
using SenseNet.ContentRepository;
using SenseNet.ContentRepository.Storage.Security;

namespace SenseNet.Demo
{
    public static class Actions
    {
        [ODataAction]
        public static Content RegisterUser(Content content, string email, string password)
        {
            if (string.IsNullOrEmpty(email))
                throw new ArgumentNullException(nameof(email));
            if (string.IsNullOrEmpty(password))
                throw new ArgumentNullException(nameof(password));

            using (new SystemAccount())
            {
                //TODO: determine custom user content type
                var user = Content.CreateNew("User", content.ContentHandler, email);
                user["Email"] = email;
                user.Save();

                return user;
            }
        }
    }
}
