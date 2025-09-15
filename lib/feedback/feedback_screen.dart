import '../utils/import_export.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        API_APP_NAME : APPLICATION_NAME,
        API_VERSiON_NO : VERSION_NO,
        API_PLATFORM : "Android",
        API_PERSON_NAME : _nameController.text.toString(),
        API_EMAIL : _emailController.text.toString(),
        API_MOBILE : _mobileController.text.toString(),
        API_MESSAGE : _messageController.text.toString(),
        API_REMARKS : null,
      };

      // For now, just print to console as integration is separate

      ApiRepo apiRepo = ApiRepo();
      apiRepo.sendData(data);



      _formKey.currentState!.reset();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: buildEnhancedAppBar(
          title: 'Feedback',
          content: "> Submit your queries"
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[

                //region Name
                feedbackFormField(controller: _nameController, title: "Name", validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                }),
                // endregion

                //region Email
                feedbackFormField(
                    controller: _emailController,
                    title: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }
                ),
                //endregion

                // region Mobile
                feedbackFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  title: "Mobile",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if(value.toString().length != 10){
                        return 'Mobile number must have exact 10 digits.';
                      }
                      return null;
                    }
                ),
                //endregion

                //region Message
                feedbackFormField(
                    controller: _messageController,
                    title: "Message",
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your feedback message';
                      }
                      return null;
                    }
                ),
                //endregion

                ElevatedButton(
                  onPressed: _submitFeedback,
                  child: const Text('Submit Feedback'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget feedbackFormField({ required controller ,title , maxLines ,validator, keyboardType}){
    return Column(
      children: [
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(
              color: cyberpunkGreen.withValues(alpha: 0.4),
              fontFamily: 'monospace',
              fontSize: 16,
            ),
            border: const OutlineInputBorder(),
          ),
          keyboardType: keyboardType,
          validator: validator,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

