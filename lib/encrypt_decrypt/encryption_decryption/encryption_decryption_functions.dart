import 'package:cipher_decoder/utils/import_export.dart';

Widget description({required context, controller}){
  if(controller is EncodeController || controller is DecodeController){
    return const SizedBox(height: 0,);
  }
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getDescriptionList(controller: controller,context: context),
         // Text(controller.desc.value)

        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 12),
          child: Text(
            controller.desc.value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF00FFFF),
              fontFamily: 'monospace',
              height: 1.4,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
}


Widget getDescriptionList({ controller , context}){
  return ListView.builder(
    shrinkWrap: true,
    itemCount: controller.options.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF00FF41),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FF41).withOpacity(0.6),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  '${index + 1}. ${controller.options[index].title!.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00FF41),
                    fontFamily: 'monospace',
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF00FF41).withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(3),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00FF41).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF00FF41),
                    fontFamily: 'monospace',
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Description with terminal-style divider
          Container(
            padding: const EdgeInsets.only(left: 20),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: const Color(0xFF00FFFF).withOpacity(0.3),
                  width: 2,
                ),
              ),
            ),
            child: Text(
              controller.options[index].description!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF00FFFF),
                fontFamily: 'monospace',
                height: 1.5,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      );
    },
  );
}
