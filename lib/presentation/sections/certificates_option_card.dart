import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/paper_certificates_bloc.dart';
import 'package:portal_ckc/bloc/bloc_event_state/sign_up_certificates_bloc.dart';
import 'package:portal_ckc/bloc/event/certificates_event.dart';
import 'package:portal_ckc/bloc/event/student_paper_certificates_event.dart';
import 'package:portal_ckc/bloc/state/student_paper_certificates_state.dart';
import 'package:portal_ckc/presentation/sections/dialogs/snack_bar_scaffold.dart';
import 'package:portal_ckc/bloc/event/sign_up_certificates_event.dart';

class CertificatesOptionCard extends StatefulWidget {
  final List<int> selectedId;
  CertificatesOptionCard({super.key, required this.selectedId});
  @override
  State<CertificatesOptionCard> createState() => CertificatesCard();
}

class CertificatesCard extends State<CertificatesOptionCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PaperCertificatesBloc>().add(PaperCertificatesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaperCertificatesBloc, StudentPaperCertificatesState>(
      builder: (context, state) {
        if (state is StudentPaperCertificatesLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state is StudentPaperCertificatesLoaded) {
          final papers = state!.papers;
          if (papers.isEmpty) {
            return Center(child: Text('Không có danh sách'));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: papers.length,
                  itemBuilder: (context, index) {
                    final isSelected = widget.selectedId.contains(
                      papers[index].id,
                    );
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[300]!,
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
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  widget.selectedId.add(papers[index].id);
                                } else {
                                  widget.selectedId.remove(papers[index].id);
                                }
                              });
                              print(
                                'loai giay được chọn: ${widget.selectedId}',
                              );
                            },
                            activeColor: Colors.blue[600],
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            title: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.my_library_books,
                                    color: Colors.blueGrey[100],
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        papers[index].tenGiay ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // xử lý gửi request
                      context.read<SignUpCertificatesBloc>().add(
                        RequestSignupCertificatesEvent(widget.selectedId),
                      );
                      // selectedId.clear();
                    },
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
                SizedBox(height: 20),
              ],
            ),
          );
        } else if (state is StudentPaperCertificatesError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('NOT FOUND | 404'));
        }
      },
    );
  }
}
