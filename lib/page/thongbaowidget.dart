import 'package:flutter/material.dart';
import 'package:app_doc_sach/model/thong_bao_model.dart';

class ThongBaoWidget extends StatefulWidget {
  const ThongBaoWidget({super.key});

  @override
  State<ThongBaoWidget> createState() => _ThongBaoWidgetState();
}

class _ThongBaoWidgetState extends State<ThongBaoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Thông báo',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const Expanded(
              child: NotificationList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: notifications.map((notification) {
          return GestureDetector(
            onTap: () {
              //Hiện thông tin chi tiết list card Thông báo
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(notification.title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        notification.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        notification.date,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6)),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            //List Thông báo
            child: Card(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.surfaceVariant
                  : Colors.white, // Brighter color for light theme
              margin: const EdgeInsets.all(8.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        notification.imageUrl,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            notification.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            notification.date,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
//Danh sách list Thông báo
List<NotificationItem> notifications = [
  NotificationItem(
    title: 'Lịch sử giáo dục 1971 - Lê Thanh Hoàng Dân',
    description:
        'Ấn phẩm "Lịch sử giáo dục" của tác giả Roger Gal, sách do dịch giả Lê Thanh Hoàng Dân và Trần Hữu Đức phiên dịch. Sách nói về lịch sử phát triển của giáo dục từ những năm 1971, với những biến đổi và tiến bộ đáng kể trong hệ thống giáo dục. Cuốn sách không chỉ là một tài liệu tham khảo quý giá cho các nhà nghiên cứu mà còn là một góc nhìn sâu sắc về quá trình hình thành và phát triển của giáo dục qua các thời kỳ lịch sử khác nhau. Được viết với phong cách rõ ràng và dễ hiểu, sách là một công cụ hữu ích cho những ai quan tâm đến lĩnh vực này.',
    date: '3 ngày trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Đứa trẻ hiểu chuyện thường không có kẹo ăn - Nguyễn Anh',
    description:
        'Cuốn sách dành cho những thời thơ ấu đầy vết thương. Trên đời này có một điều rất kỳ diệu, là sự dũng cảm và niềm tin vào cuộc sống của những đứa trẻ khi không có kẹo ăn. Những đứa trẻ ấy đã vượt qua khó khăn, đối mặt với những thử thách lớn lao mà không có sự giúp đỡ từ ai khác. Họ học cách tự đứng lên, tự chiến đấu và tự tìm thấy con đường riêng của mình. Câu chuyện cảm động này sẽ đưa người đọc trở về với những kỷ niệm tuổi thơ, để thấy rằng dũng cảm và niềm tin có thể giúp chúng ta vượt qua mọi khó khăn trong cuộc sống.',
    date: '5 ngày trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Ghi Chép Pháp Y - Tập 2 - Khi Tử Thi Biết Nói',
    description:
        'Nếu kẻ thủ ác dùng cái chết để khiến một người im lặng, thì bác sĩ pháp y sẽ giúp nạn nhân "mở miệng". Từ những dấu vết nhỏ nhất trên cơ thể, những manh mối tưởng chừng như vô hình, bác sĩ pháp y có thể dựng lại toàn bộ câu chuyện đã xảy ra. Cuốn sách này mở ra một thế giới kỳ bí, nơi khoa học pháp y trở thành công cụ mạnh mẽ giúp tìm ra sự thật và đem lại công lý cho những nạn nhân. Với từng trang sách, độc giả sẽ được trải nghiệm những vụ án ly kỳ và những phát hiện chấn động.',
    date: '6 ngày trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Bí ẩn sau cánh cửa nhà xác - Carla Valentine',
    description:
        'Cuốn sách tiết lộ sự thật đáng sợ về công việc của những người sống cùng xác chết. Carla Valentine, một chuyên gia pháp y, kể lại những trải nghiệm đáng nhớ và những câu chuyện đầy kinh hãi từ nhà xác. Độc giả sẽ được bước vào thế giới tăm tối nhưng vô cùng hấp dẫn, nơi mỗi xác chết đều mang trong mình những câu chuyện chưa kể. Từ những vụ án mạng bí ẩn cho đến những cái chết tự nhiên nhưng đầy kỳ lạ, cuốn sách này sẽ khiến bạn không thể rời mắt khỏi từng trang sách.',
    date: '6 ngày trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Ghi chép pháp y - Những cái chết bí ẩn',
    description:
        'Làm cách nào để một "xác chết lên tiếng"? - đó là công việc của bác sĩ pháp y. Cuốn sách này không chỉ là một tài liệu khoa học mà còn là một câu chuyện hấp dẫn về những vụ án mạng và những bí ẩn chưa có lời giải. Từ những phương pháp khám nghiệm hiện đại đến những suy luận logic sắc bén, các bác sĩ pháp y đã giúp giải mã nhiều vụ án khó khăn. Độc giả sẽ được theo chân các chuyên gia trong hành trình tìm kiếm sự thật, từ hiện trường vụ án cho đến phòng thí nghiệm.',
    date: '6 ngày trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Công nghệ thông tin và cuộc cách mạng công nghiệp 4.0',
    description:
        'Cuốn sách giải thích sự phát triển của công nghệ thông tin và vai trò quan trọng trong cuộc cách mạng công nghiệp thứ tư. Với những tiến bộ vượt bậc trong lĩnh vực trí tuệ nhân tạo, Internet of Things (IoT), và dữ liệu lớn, công nghệ thông tin đang thay đổi cách chúng ta sống và làm việc. Cuốn sách này cung cấp một cái nhìn tổng quan về những thay đổi lớn đang diễn ra, từ việc tự động hóa trong công nghiệp đến những đổi mới trong dịch vụ chăm sóc sức khỏe và giáo dục. Độc giả sẽ hiểu rõ hơn về tác động của công nghệ đến xã hội và những cơ hội mà nó mang lại.',
    date: '1 tuần trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Cuộc đua bản đồ thế giới - Mark Monmonier',
    description:
        'Bộ sách phân tích cách mà bản đồ đã giúp đỡ những nước nào tham gia cuộc đua xây dựng thế giới hiện đại. Mark Monmonier, một nhà địa lý học nổi tiếng, khám phá cách các bản đồ đã được sử dụng như một công cụ quyền lực để định hình các quốc gia và ảnh hưởng đến chính trị toàn cầu. Từ những bản đồ cổ đại cho đến những ứng dụng công nghệ bản đồ hiện đại, cuốn sách này đưa độc giả vào hành trình khám phá lịch sử và tầm quan trọng của bản đồ trong sự phát triển của thế giới.',
    date: '2 tuần trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Thiên tài và kẻ điên - John Nash',
    description:
        'Cuốn sách kể về cuộc đời và sự nghiệp của thiên tài toán học John Nash, người đã chiến thắng bệnh tâm thần và đạt giải Nobel. John Nash, với những cống hiến to lớn cho lý thuyết trò chơi và toán học, đã để lại dấu ấn sâu sắc trong lịch sử khoa học. Tuy nhiên, cuộc đời ông không chỉ có vinh quang mà còn đầy rẫy những khó khăn và thử thách do chứng tâm thần phân liệt gây ra. Cuốn sách này là một câu chuyện cảm động về sự đấu tranh, nghị lực và khát vọng sống của một con người vĩ đại.',
    date: '3 tuần trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Sự nổi loạn của đám đông - Gustave Le Bon',
    description:
        'Nghiên cứu về tâm lý học đám đông và tác động của nó đến xã hội hiện đại. Gustave Le Bon, một nhà tâm lý học tiên phong, đã đưa ra những phân tích sâu sắc về cách mà đám đông hoạt động và ảnh hưởng đến hành vi của cá nhân. Từ những cuộc cách mạng lịch sử cho đến các phong trào xã hội hiện đại, cuốn sách này cung cấp một góc nhìn độc đáo về sức mạnh và nguy cơ của đám đông. Độc giả sẽ hiểu rõ hơn về những yếu tố thúc đẩy hành vi tập thể và cách chúng định hình xã hội.',
    date: '1 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Chiến tranh và hòa bình - Lev Tolstoy',
    description:
        'Tác phẩm văn học kinh điển kể về cuộc sống trong thời kỳ Napoleon xâm lược nước Nga. Lev Tolstoy, một trong những nhà văn vĩ đại nhất mọi thời đại, đã khắc họa một bức tranh rộng lớn về xã hội Nga trong thời kỳ biến động. Cuốn sách này không chỉ là một câu chuyện về chiến tranh mà còn là một bài ca về tình yêu, lòng dũng cảm và sự hy sinh. Với những nhân vật đa dạng và những tình tiết phong phú, "Chiến tranh và hòa bình" mang đến cho độc giả một trải nghiệm đọc sâu sắc và đầy cảm xúc.',
    date: '1 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Những kẻ mộng mơ - Karen Thompson Walker',
    description:
        'Câu chuyện về một dịch bệnh khiến mọi người rơi vào giấc ngủ vô tận và những bí ẩn xung quanh nó. Khi cả một thị trấn nhỏ bị mắc kẹt trong những giấc mơ sâu, những người còn lại phải đối mặt với những quyết định khó khăn và những hiểm nguy tiềm ẩn. Karen Thompson Walker đã tạo nên một bầu không khí đầy ám ảnh và kỳ bí, nơi mà ranh giới giữa thực tại và giấc mơ trở nên mờ nhạt. Cuốn sách này là một hành trình khám phá tâm lý con người và sức mạnh của những giấc mơ.',
    date: '1 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Mật mã Da Vinci - Dan Brown',
    description:
        'Cuốn tiểu thuyết trinh thám nổi tiếng khám phá những bí ẩn của Leonardo da Vinci. Robert Langdon, một giáo sư biểu tượng học tại Harvard, bị cuốn vào một âm mưu bí mật liên quan đến những tác phẩm nghệ thuật của Da Vinci. Từ những hành lang của bảo tàng Louvre cho đến những nhà thờ cổ kính ở châu Âu, Langdon phải giải mã những manh mối để ngăn chặn một âm mưu nguy hiểm. Với những tình tiết hấp dẫn và bất ngờ, "Mật mã Da Vinci" đã chinh phục hàng triệu độc giả trên toàn thế giới.',
    date: '2 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Nghệ thuật chiến tranh - Tôn Tử',
    description:
        'Cuốn sách cổ điển về chiến lược quân sự và quản lý được sử dụng rộng rãi trong kinh doanh và chính trị. "Nghệ thuật chiến tranh" của Tôn Tử, một tác phẩm có tuổi đời hơn 2000 năm, vẫn giữ nguyên giá trị và sự ảnh hưởng đến ngày nay. Cuốn sách bao gồm những chiến lược và chiến thuật tinh vi, không chỉ áp dụng trong chiến tranh mà còn trong quản lý và lãnh đạo. Với những lời khuyên sắc bén và trí tuệ sâu sắc, Tôn Tử đã tạo ra một tác phẩm mà bất kỳ ai quan tâm đến chiến lược và quản lý đều nên đọc.',
    date: '2 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Nhà giả kim - Paulo Coelho',
    description:
        'Hành trình của một chàng trai trẻ đi tìm kho báu và khám phá chính bản thân mình. Santiago, một chàng chăn cừu trẻ tuổi, quyết định rời bỏ cuộc sống yên bình để đi tìm kho báu trong giấc mơ của mình. Trên đường đi, anh gặp gỡ nhiều người và học được những bài học quý giá về cuộc sống và tình yêu. "Nhà giả kim" không chỉ là một câu chuyện phiêu lưu kỳ thú mà còn là một cuốn sách truyền cảm hứng, khuyến khích độc giả theo đuổi ước mơ và tin tưởng vào khả năng của mình.',
    date: '3 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Cuộc sống bí mật của cây cối - Peter Wohlleben',
    description:
        'Cuốn sách tiết lộ những điều kỳ diệu về cách cây cối giao tiếp và tương tác với môi trường. Peter Wohlleben, một nhà bảo tồn thiên nhiên, đã dành nhiều năm nghiên cứu và khám phá những bí mật của thế giới thực vật. Ông cho thấy rằng cây cối không chỉ là những sinh vật thụ động mà còn có khả năng giao tiếp, cảm nhận và thậm chí là chăm sóc lẫn nhau. Cuốn sách này mở ra một thế giới mới về cây cối và mối quan hệ phức tạp giữa chúng và môi trường xung quanh.',
    date: '3 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Tư duy nhanh và chậm - Daniel Kahneman',
    description:
        'Cuốn sách khám phá hai hệ thống tư duy của con người và ảnh hưởng của chúng đến quyết định hàng ngày. Daniel Kahneman, một nhà tâm lý học đoạt giải Nobel, đã đưa ra những phát hiện đột phá về cách mà con người suy nghĩ và ra quyết định. Ông mô tả hai hệ thống tư duy: hệ thống 1, nhanh và trực giác, và hệ thống 2, chậm và có suy nghĩ. Cuốn sách này cung cấp những hiểu biết sâu sắc về tâm lý con người và những yếu tố ảnh hưởng đến quyết định của chúng ta trong cuộc sống hàng ngày.',
    date: '4 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: '21 bài học cho thế kỷ 21 - Yuval Noah Harari',
    description:
        'Những thách thức và cơ hội trong thế kỷ 21 được giải thích qua lăng kính của lịch sử và tương lai. Yuval Noah Harari, tác giả của các cuốn sách nổi tiếng như "Sapiens" và "Homo Deus", tiếp tục đưa ra những phân tích sắc bén về các vấn đề đương đại. Từ công nghệ, chính trị, cho đến tôn giáo và giáo dục, Harari cung cấp một góc nhìn toàn diện về những thay đổi lớn đang diễn ra và những gì chúng ta cần làm để đối mặt với tương lai. Cuốn sách này là một nguồn tài liệu quý giá cho bất kỳ ai muốn hiểu rõ hơn về thế giới ngày nay.',
    date: '4 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Người viết sử - Graham Hancock',
    description:
        'Khám phá những nền văn minh cổ đại và những bí ẩn chưa được giải đáp của lịch sử loài người. Graham Hancock, một nhà khảo cổ học nổi tiếng, đã dành nhiều năm nghiên cứu và tìm kiếm những bằng chứng về những nền văn minh đã mất. Cuốn sách này đưa độc giả vào một cuộc hành trình kỳ thú qua thời gian, từ những kim tự tháp Ai Cập cho đến những thành phố cổ đại bị lãng quên. Với những phát hiện mới mẻ và những giả thuyết táo bạo, "Người viết sử" là một cuốn sách không thể bỏ qua cho những ai yêu thích lịch sử và khảo cổ học.',
    date: '5 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Biến mất trong đêm - Alex Michaelides',
    description:
        'Cuốn tiểu thuyết trinh thám về một người phụ nữ mất tích và những bí ẩn xung quanh sự kiện này. Khi Alicia Berenson, một họa sĩ nổi tiếng, bị phát hiện đứng bên xác chồng mình với khẩu súng trên tay, cô hoàn toàn im lặng và không nói một lời nào. Cuộc điều tra dẫn đến những khám phá gây sốc về quá khứ của cô và những bí mật đen tối mà cô đã che giấu. Với những tình tiết ly kỳ và những cú plot twist bất ngờ, "Biến mất trong đêm" là một cuốn sách mà độc giả sẽ không thể bỏ xuống.',
    date: '5 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Thiên đường đã mất - John Milton',
    description:
        'Tác phẩm kinh điển kể về cuộc nổi loạn của Satan và sự sa ngã của Adam và Eve. John Milton, một nhà thơ vĩ đại, đã tạo nên một kiệt tác văn học với "Thiên đường đã mất". Cuốn sách kể về cuộc nổi loạn của Satan và cuộc chiến giữa thiên đàng và địa ngục, dẫn đến sự sa ngã của con người. Với ngôn ngữ phong phú và hình ảnh sống động, Milton đã đưa người đọc vào một hành trình đầy kịch tính và cảm xúc. "Thiên đường đã mất" là một tác phẩm kinh điển mà mọi người yêu thích văn học nên đọc ít nhất một lần trong đời.',
    date: '6 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
  NotificationItem(
    title: 'Người mẹ dũng cảm - Fredrik Backman',
    description:
        'Câu chuyện cảm động về một người mẹ chiến đấu để bảo vệ gia đình và giữ vững niềm tin. Trong một thị trấn nhỏ nơi mọi người đều biết nhau, Britt-Marie, một người mẹ đơn thân, phải đối mặt với những khó khăn và thách thức lớn lao. Bằng tình yêu thương và sự quyết tâm, cô đã tìm ra cách vượt qua mọi trở ngại để bảo vệ gia đình mình. Fredrik Backman, tác giả của nhiều cuốn sách bán chạy, đã viết nên một câu chuyện đầy nhân văn và cảm động về lòng dũng cảm và sức mạnh của tình yêu. Cuốn sách này sẽ chạm đến trái tim của bất kỳ ai đọc nó.',
    date: '6 tháng trước',
    imageUrl: 'assets/book/matbiec.png',
  ),
];

