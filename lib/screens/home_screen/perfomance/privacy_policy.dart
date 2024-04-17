import 'package:flutter/material.dart';
import 'package:schedulia/class/custom_textstyle.dart';

class PrivacyPolicyScrren extends StatelessWidget {
  const PrivacyPolicyScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: const [
          Text('SCHEDULIA', style: MyTextStyle.appNameStyle),
          SizedBox(width: 20)
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text('Privacy Policy', style: MyTextStyle.privacypolicyStyle),
              SizedBox(height: 20),
              Text(
                'We built  SCHEDULIA - The Mini Scheduler app as a Free app. This SERVICE is provided by us at no cost and is intended for use as is.\n\nThis page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.\n\nIf you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.',
                style: MyTextStyle.privacypolicybodyStyle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20),
                child: Text('Information We Collect',
                    style: MyTextStyle.privacypolicyHeadingStyle),
              ),
              Text(
                'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to your name and photo. The information that we request will be retained by us and used as described in this privacy policy.',
                style: MyTextStyle.privacypolicybodyStyle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Photos',
                  style: MyTextStyle.privacypolicyHeadingStyle,
                ),
              ),
              Text(
                  'SCHEDULIA - The Mini Scheduler app may allow you to upload photos for use within the app. These photos are stored locally on your device and are not transmitted to external servers.'),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Log Data',
                  style: MyTextStyle.privacypolicyHeadingStyle,
                ),
              ),
              Text(
                  'We want to inform you that whenever you use our Service, in a case of an error in the app, we may collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.'),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Security',
                  style: MyTextStyle.privacypolicyHeadingStyle,
                ),
              ),
              Text(
                  'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.'),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Children\'s privacy',
                  style: MyTextStyle.privacypolicyHeadingStyle,
                ),
              ),
              Text(
                  'These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to take necessary actions.'),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Changes to This Privacy Policy',
                  style: MyTextStyle.privacypolicyHeadingStyle,
                ),
              ),
              Text(
                'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\n\n This policy is effective as of 7-Apr-2024.',
                style: MyTextStyle.privacypolicybodyStyle,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Contact Us',
                  style: MyTextStyle.privacypolicyHeadingStyle,
                ),
              ),
              Text(
                  'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at pknidhanidh@gmail.com.')
            ],
          ),
        ),
      ),
    );
  }
}
