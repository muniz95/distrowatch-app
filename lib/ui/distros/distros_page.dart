import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/ui/common/info_message_view.dart';
import 'package:distrowatchapp/ui/common/loading_view.dart';
import 'package:distrowatchapp/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:distrowatchapp/ui/distros/distros_page_view_model.dart';
import 'package:distrowatchapp/ui/distros/distros_list.dart';

class DistrosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DistrosPageViewModel>(
      distinct: true,
      converter: (store) => DistrosPageViewModel.fromStore(store),
      builder: (_, viewModel) => new DistrosPageContent(viewModel),
    );
  }
}

class DistrosPageContent extends StatelessWidget {
  DistrosPageContent(this.viewModel);
  final DistrosPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new LoadingView(
            status: viewModel.status,
            loadingContent: new PlatformAdaptiveProgressIndicator(),
            errorContent: new ErrorView(onRetry: viewModel.refreshDistros),
            successContent: new DistrosList(viewModel.distros, viewModel.refreshDistros),
          ),
        ),
      ],
    );
  }
}