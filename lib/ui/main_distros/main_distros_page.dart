import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/ui/common/info_message_view.dart';
import 'package:distrowatchapp/ui/common/loading_view.dart';
import 'package:distrowatchapp/ui/common/platform_adaptive_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:distrowatchapp/ui/main_distros/main_distros_page_view_model.dart';
import 'package:distrowatchapp/ui/main_distros/main_distros_list.dart';

class MainDistrosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, MainDistrosPageViewModel>(
      distinct: true,
      converter: (store) => MainDistrosPageViewModel.fromStore(store),
      builder: (_, viewModel) => new MainDistrosPageContent(viewModel),
    );
  }
}

class MainDistrosPageContent extends StatelessWidget {
  MainDistrosPageContent(this.viewModel);
  final MainDistrosPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(
          child: new LoadingView(
            status: viewModel.status,
            loadingContent: new PlatformAdaptiveProgressIndicator(),
            errorContent: new ErrorView(onRetry: viewModel.refreshMainDistros),
            successContent: new MainDistrosList(viewModel.mainDistros),
          ),
        ),
        new FlatButton(
          onPressed: () => viewModel.refreshMainDistros(),
          child: new Text('Refresh'),
        ),
      ],
    );
  }
}