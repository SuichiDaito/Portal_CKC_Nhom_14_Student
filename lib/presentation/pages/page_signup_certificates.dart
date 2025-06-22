import 'package:flutter/material.dart';
import 'package:portal_ckc/presentation/sections/card/student_card_info.dart';

class CertificateRegistrationScreen extends StatefulWidget {
  @override
  _CertificateRegistrationScreenState createState() =>
      _CertificateRegistrationScreenState();
}

class _CertificateRegistrationScreenState
    extends State<CertificateRegistrationScreen> {
  // Checkbox states
  bool _tempResidenceDoc = false;
  bool _scholarshipDoc = false;
  bool _militaryDefermentDoc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Đăng ký giấy xác nhận',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Info Card
              StudentCardInfo(),
              SizedBox(height: 24),
              // Certificate Selection Section
              Text(
                'Chọn loại giấy cần đăng ký',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),

              SizedBox(height: 16),

              // Certificate Options
              _buildCertificateOption(
                title: 'Giấy bổ túc hồ sơ tạm trú, tạm vắng',
                description:
                    'Xác nhận thông tin tạm trú, tạm vắng của sinh viên',
                icon: Icons.home,
                value: _tempResidenceDoc,
                onChanged: (value) {
                  setState(() {
                    _tempResidenceDoc = value!;
                  });
                },
              ),

              SizedBox(height: 12),

              _buildCertificateOption(
                title: 'Giấy bổ túc hồ sơ xin học bổng',
                description: 'Xác nhận thông tin để hỗ trợ hồ sơ xin học bổng',
                icon: Icons.school,
                value: _scholarshipDoc,
                onChanged: (value) {
                  setState(() {
                    _scholarshipDoc = value!;
                  });
                },
              ),

              SizedBox(height: 12),

              _buildCertificateOption(
                title: 'Giấy tạm hoãn nghĩa vụ quân sự',
                description:
                    'Xác nhận tình trạng học tập để hoãn nghĩa vụ quân sự',
                icon: Icons.security,
                value: _militaryDefermentDoc,
                onChanged: (value) {
                  setState(() {
                    _militaryDefermentDoc = value!;
                  });
                },
              ),

              SizedBox(height: 32),

              // Submit Button
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _hasSelectedCertificate()
                      ? _submitRegistration
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCertificateOption({
    required String title,
    required String description,
    required IconData icon,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? Colors.blue[600]! : Colors.grey[300]!,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue[600],
        checkColor: Colors.white,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: value ? Colors.blue[600] : Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasSelectedCertificate() {
    return _tempResidenceDoc || _scholarshipDoc || _militaryDefermentDoc;
  }

  void _submitRegistration() {
    List<String> selectedCertificates = [];

    if (_tempResidenceDoc) {
      selectedCertificates.add('Giấy bổ túc hồ sơ tạm trú, tạm vắng');
    }
    if (_scholarshipDoc) {
      selectedCertificates.add('Giấy bổ túc hồ sơ xin học bổng');
    }
    if (_militaryDefermentDoc) {
      selectedCertificates.add('Giấy tạm hoãn nghĩa vụ quân sự');
    }

    //
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Xác nhận đăng ký',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bạn đã chọn đăng ký các loại giấy sau:'),
              SizedBox(height: 12),
              ...selectedCertificates
                  .map(
                    (cert) => Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text(cert)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessMessage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
              ),
              child: Text('Xác nhận', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đăng ký thành công! Vui lòng chờ xử lý.'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
