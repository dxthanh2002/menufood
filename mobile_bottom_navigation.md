# Tổng hợp chi tiết lời khuyên về **Mobile Bottom Navigation**

## Ghi chú về nguồn
Bản tổng hợp này **không phải transcript nguyên văn từng câu** của video YouTube. Nội dung được tổng hợp sát nhất có thể từ:
- bài viết companion của **uxpeak** liên kết trực tiếp tới đúng video này,
- và đối chiếu thêm với guideline chính thức của **Apple** và **Material Design**.

Vì vậy, tài liệu này phù hợp để dùng làm **ghi chú học tập / checklist thiết kế**, hơn là bản chép lời từng phút của video.

---

## 1) Bottom navigation dùng khi nào?
Bottom navigation nên được dùng cho các **điểm đến cấp cao nhất** trong app, tức là những khu vực chính mà người dùng truy cập thường xuyên. Nó không nên là nơi nhét mọi tính năng phụ hay mọi lối tắt có thể có.

### Ý chính
- Dùng cho **top-level destinations**.
- Mỗi tab nên đại diện cho **một khu vực nội dung hoặc workflow rõ ràng**.
- Người dùng phải nhìn tab là đoán được app có gì và đi đâu.

### Ý nghĩa UX
Khi bottom navigation phản ánh đúng cấu trúc thông tin, người dùng sẽ hình thành bản đồ tinh thần rõ ràng hơn. Họ biết:
- mình đang ở đâu,
- mỗi tab dùng để làm gì,
- và nên chuyển đi đâu tiếp theo.

### Không nên
- Dùng bottom nav cho các hành động phụ.
- Nhét nhiều feature không liên quan vào một tab “Home” kiểu tổng hợp mọi thứ.
- Dùng tab để che đi việc IA (information architecture) đang yếu.

---

## 2) Giới hạn số lượng tab: lý tưởng là **3–5 tab**
Đây là một trong những lời khuyên quan trọng nhất.

### Vì sao?
Nếu có quá nhiều tab:
- mỗi mục sẽ nhỏ hơn,
- khó chạm chính xác hơn,
- người dùng bị quá tải lựa chọn,
- giao diện trông chật chội và thiếu thứ bậc.

### Kết luận thực dụng
- **3–5 tab** là vùng an toàn.
- Nếu ít hơn 3, có thể bạn chưa cần bottom nav.
- Nếu nhiều hơn 5, nên cân nhắc:
  - gom nhóm lại,
  - ưu tiên các khu vực chính,
  - chuyển phần còn lại sang pattern khác.

### Cách chọn tab nào được lên thanh dưới
Ưu tiên các mục:
- được dùng thường xuyên,
- là phần cốt lõi của sản phẩm,
- có thể đứng độc lập và dễ hiểu,
- không trùng vai trò với tab khác.

---

## 3) Thiết kế anatomy hợp lý: kích thước, padding, khoảng cách
uxpeak nhấn mạnh rằng bottom nav phải “fit” với thiết bị, chứ không có một con số thần thánh áp cho mọi màn hình.

### Các mốc gợi ý
- **Icon**: khoảng **24px**
- **Label**: khoảng **10–12px**
- Nên thử trên **2–3 độ rộng màn hình khác nhau**
- Trên iPhone có **home indicator** ở dưới, cần chừa không gian hợp lý

### Ý tưởng cốt lõi
Thanh điều hướng phải:
- đủ rõ để nhìn ra,
- đủ lớn để chạm,
- nhưng không được ăn quá nhiều diện tích nội dung.

### Sai lầm thường gặp
- Bar quá cao → app bị nặng đáy màn hình.
- Label quá to → rối và tranh chỗ với nội dung.
- Label quá nhỏ → kém đọc, giảm accessibility.
- Chỉ thiết kế cho một cỡ máy → lên máy nhỏ hoặc lớn là vỡ bố cục.

---

## 4) Tap target phải thân thiện với ngón tay
Đừng chỉ nhìn kích thước icon; thứ quan trọng là **vùng chạm thực tế**.

### Khuyến nghị
- Vùng chạm nên tối thiểu khoảng **44 × 44**.

### Vì sao quan trọng?
- Người dùng thường thao tác bằng ngón cái.
- Màn hình lớn càng dễ gây chạm trượt nếu target quá nhỏ.
- Tap area rộng hơn giúp giảm mis-tap và tăng accessibility.

### Nhớ điều này
Một icon 24px có thể ổn về mặt thị giác, nhưng nếu vùng chạm quanh nó quá nhỏ thì trải nghiệm vẫn tệ.

---

## 5) Active state và inactive state phải khác nhau đủ rõ
Người dùng cần biết ngay lập tức: **mình đang ở tab nào**.

### uxpeak gợi ý
Nên thay đổi ít nhất **2 yếu tố** giữa trạng thái active và inactive, ví dụ:
- đổi màu icon,
- đổi màu label,
- làm label đậm hơn,
- đổi icon từ outline sang filled.

### Vì sao 1 thay đổi là chưa đủ?
Nếu chỉ đổi mỗi text hoặc đổi quá nhẹ:
- người dùng nhận biết chậm hơn,
- khó định vị vị trí hiện tại,
- điều hướng có cảm giác kém chắc chắn.

### Thực hành tốt
- Active phải nổi bật vừa đủ.
- Inactive vẫn phải dễ đọc, nhưng lùi về vai phụ.
- Đừng làm active state quá lòe loẹt như một CTA.

---

## 6) Chọn icon **đơn giản, quen thuộc, dễ đoán**
Icon trong bottom nav không phải chỗ để “khoe sáng tạo” quá mức.

### Nguyên tắc
- Ưu tiên icon mà người dùng nhận ra ngay.
- Icon phải biểu đạt đúng chức năng.
- Dùng hình đơn giản, ít chi tiết.

### Ví dụ tư duy đúng
- Search → kính lúp là lựa chọn quen thuộc.
- Tránh biểu tượng lạ, ẩn dụ quá xa, hoặc cần suy nghĩ mới hiểu.

### Lưu ý thêm
Một icon đẹp nhưng khó đoán nghĩa thì vẫn là icon thất bại về UX.

---

## 7) Label phải **ngắn, rõ, một dòng**
Label tốt giúp người dùng ra quyết định nhanh hơn.

### Nên làm
- Giữ label ngắn.
- Chỉ dùng **một dòng**.
- Dùng từ phổ biến, dễ hiểu.

### Không nên
- Label dài bị xuống 2 dòng.
- Dùng thuật ngữ nội bộ của team.
- Dùng chữ mơ hồ như “Explore More Stuff”, “Everything”, “General”.

### Tác động
Label ngắn:
- làm thanh nav gọn hơn,
- giúp scan nhanh hơn,
- và tạo cảm giác hiện đại, sạch sẽ hơn.

---

## 8) Giữ giao diện **sạch và tối giản**
uxpeak khuyên tránh thêm các yếu tố trang trí thừa, ví dụ box bao quanh từng tab.

### Tại sao?
Bottom navigation là công cụ định hướng, không nên giành spotlight với nội dung chính.

### Cần hướng tới
- dễ đọc,
- dễ chạm,
- ít nhiễu thị giác,
- không gây cảm giác “đè” lên nội dung.

### Dấu hiệu giao diện đang bị overdesigned
- quá nhiều nền phụ,
- viền nặng,
- hiệu ứng thừa,
- tab nào cũng cố nổi bật như nhau.

---

## 9) Giữ **một style icon nhất quán**
Không nên trộn lẫn icon filled, outline, dày, mảnh, bo tròn, sắc cạnh một cách ngẫu nhiên.

### Quy tắc dễ nhớ
- Tất cả tab nên dùng cùng một ngôn ngữ icon.
- Điểm ngoại lệ hợp lý là **tab đang active** có thể chuyển từ outline sang filled.

### Không chỉ là style, còn là mức độ phức tạp
Nếu một icon rất tối giản mà icon khác nhiều chi tiết:
- thanh nav sẽ mất cân bằng thị giác,
- trông thiếu chuyên nghiệp,
- người dùng cảm thấy không đồng nhất dù không gọi tên được lý do.

---

## 10) Đừng dùng quá nhiều màu
Việc gán mỗi tab một màu khác nhau thường làm nav trở nên ồn ào hơn là hữu ích.

### Rủi ro
- phân tán sự chú ý,
- cạnh tranh với nội dung,
- làm yếu nhận diện thương hiệu,
- khiến người dùng phải “giải mã màu” thay vì điều hướng tự nhiên.

### Cách làm tốt hơn
- bám vào palette thương hiệu,
- dùng màu nhấn chủ yếu cho active state,
- để inactive ở trạng thái trung tính.

### Tư duy đúng
Bottom nav nên là một phần của hệ thống giao diện, không phải bảng màu mini.

---

## 11) Badge chỉ dùng cho thông tin thực sự đáng chú ý
Badge có thể rất hiệu quả nếu dùng đúng.

### Dùng badge khi nào?
- Có cập nhật mới thực sự quan trọng.
- Có tin nhắn / thông báo / trạng thái cần người dùng chú ý.

### Cách dùng tốt
- badge nhỏ nhưng đủ thấy,
- thường đặt ở **góc trên bên phải** của icon,
- nếu có số thì phải đọc nhanh được,
- màu badge phải nổi nhưng vẫn nằm trong hệ visual của app.

### Không nên
- badge cho mọi thứ,
- badge quá to,
- font số quá nhỏ hoặc quá kiểu cách,
- lạm dụng đến mức người dùng “miễn nhiễm” với cảnh báo.

---

## 12) Tách bottom navigation khỏi nội dung chính
Nếu không có sự tách bạch, thanh nav rất dễ hòa lẫn vào nội dung, đặc biệt khi màn hình có nhiều thông tin hoặc khi scroll.

### Mục tiêu
Người dùng phải hiểu ngay:
- đây là khu vực điều hướng,
- kia là khu vực nội dung.

### Cách tách thường dùng
- đường phân cách mảnh,
- sự khác biệt nhẹ về surface/background,
- elevation/shadow rất nhẹ,
- safe area và spacing hợp lý.

### Nguyên tắc
Tách đủ để rõ ràng, nhưng không nặng đến mức giống một khối UI lạ tách rời app.

---

## 13) Tab bar nên **persistent** và giữ ngữ cảnh ổn định
Đây là phần rất quan trọng khi đối chiếu với guideline của Apple.

### Nên làm
- Giữ tab bar hiện diện ổn định qua các khu vực chính.
- Mỗi tab giữ ngữ cảnh riêng của nó.
- Khi quay lại tab trước, người dùng nên cảm thấy trạng thái được bảo toàn hợp lý.

### Tránh làm
- tự động chuyển người dùng sang tab khác,
- ẩn/hiện tab bar thất thường mà không có lý do mạnh,
- biến tab bar thành một nơi chứa shortcut chồng chéo.

### Vì sao?
Một lợi ích lớn của tab navigation là người dùng có thể qua lại giữa các khu vực chính mà vẫn giữ được cảm giác định hướng. Nếu app tự đổi tab hoặc làm tab bar biến mất khó đoán, cảm giác kiểm soát sẽ giảm mạnh.

---

## 14) Tránh tab “Home” kiểu ôm tất cả chức năng
Apple đặc biệt nhấn mạnh lỗi này.

### Vấn đề của tab Home tổng hợp
- mọi feature tranh nhau chỗ,
- cấu trúc thông tin bị mờ,
- người dùng không hiểu “cái gì thuộc về đâu”,
- cùng một hành động có thể lặp ở nhiều tab → gây rối.

### Khi nào Home vẫn ổn?
Chỉ khi “Home” thật sự là một bề mặt có mục tiêu rõ ràng, ví dụ:
- feed chính,
- dashboard cá nhân,
- overview có logic mạnh.

Nếu “Home” chỉ là nơi nhét tất cả cho dễ discover thì đó thường là dấu hiệu IA chưa ổn.

---

## 15) Bottom nav tốt là thứ gần như “vô hình”
Một bottom nav tốt không phải là thứ người dùng phải chú ý nhiều. Nó tốt khi:
- luôn sẵn ở đúng chỗ,
- dễ hiểu,
- dễ chạm,
- không làm phiền,
- và giúp người dùng đi tiếp gần như theo bản năng.

Nói cách khác: **điều hướng tốt thường ít bị nhận ra, vì mọi thứ diễn ra quá tự nhiên**.

---

# Checklist thiết kế nhanh

## Nên kiểm tra trước khi chốt UI
- [ ] Bottom nav có đúng là dành cho các khu vực cấp cao nhất không?
- [ ] Có từ 3 đến 5 tab không?
- [ ] Mỗi tab có vai trò rõ ràng, không chồng chéo không?
- [ ] Icon có quen thuộc, đơn giản, cùng style không?
- [ ] Label có ngắn, dễ hiểu, 1 dòng không?
- [ ] Active state có khác rõ bằng ít nhất 2 tín hiệu thị giác không?
- [ ] Vùng chạm có đủ lớn để chạm thoải mái không?
- [ ] Màu sắc có tiết chế và đồng nhất với brand không?
- [ ] Badge có đang bị lạm dụng không?
- [ ] Bottom nav có tách đủ rõ khỏi nội dung không?
- [ ] Tab bar có giữ ổn định và không tự động nhảy tab không?

---

# Những lỗi phổ biến cần tránh
- Có hơn 5 tab.
- Dùng icon lạ, khó đoán.
- Label dài xuống 2 dòng.
- Active state quá yếu.
- Mỗi tab một style icon khác nhau.
- Mỗi tab một màu khác nhau.
- Vùng chạm nhỏ hơn mức an toàn.
- Nhét mọi thứ vào tab “Home”.
- Tự động chuyển người dùng sang tab khác.
- Dùng badge quá nhiều đến mức mất tác dụng.

---

# Một spec khởi điểm thực dụng
Đây là bộ thông số khởi điểm tốt để prototype nhanh:

- **Số tab:** 4
- **Kích thước icon:** 24px
- **Label:** 11–12px
- **Tap target tối thiểu:** 44×44
- **Active:** đổi màu icon + đổi màu/độ đậm label
- **Inactive:** trung tính, vẫn đủ tương phản
- **Badge:** chỉ cho thông báo quan trọng
- **Separator:** 1 đường mảnh hoặc elevation rất nhẹ

Sau đó test trên:
- màn hình nhỏ,
- màn hình trung bình,
- màn hình lớn,
- và test chạm thực tế bằng ngón cái.

---

# Kết luận ngắn gọn
Nếu rút toàn bộ video/nguồn thành vài ý nhớ nhanh thì là:

1. Dùng bottom nav cho **top-level destinations**.
2. Giữ ở **3–5 tab**.
3. Đảm bảo **tap target đủ lớn**.
4. Làm **active state thật rõ**.
5. Dùng **icon quen thuộc + label ngắn**.
6. Giữ **style nhất quán, ít màu, ít nhiễu**.
7. Dùng **badge có chọn lọc**.
8. Tách nav khỏi nội dung.
9. Giữ tab bar **persistent và ổn định**.
10. Tránh tab “Home” kiểu gom tất cả.

---

# Nguồn tham chiếu đã dùng để tổng hợp
- **uxpeak** — *Top UI/UX Design Tips: How to Design a Great Bottom Mobile Navigation Bar, part 6* (bài companion có liên kết trực tiếp tới video YouTube cùng chủ đề)
- **Apple Developer** — *UI Design Dos and Don’ts* (44×44 hit target, text legibility)
- **Apple Developer WWDC22** — *Explore navigation design for iOS* (top-level hierarchy, labels rõ ràng, tránh duplicate functionality, giữ tab bar persistent)
- **Material Design / Material UI** — bottom navigation / navigation bar guidance (3–5 destinations)
