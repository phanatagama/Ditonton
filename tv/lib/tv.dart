library tv;

// data
// data -> data sources
export 'data/datasources/tv_local_data_source.dart';
export 'data/datasources/tv_remote_data_source.dart';
// data -> repositories
export 'data/repositories/tv_repository_impl.dart';
// data -> models
export 'data/models/tv_table.dart';
export 'data/models/tv_detail_model.dart';
export 'data/models/tv_model.dart';
export 'data/models/tv_response.dart';

// domain
// domain -> entities
export 'domain/entities/tv.dart';
export 'domain/entities/tv_detail.dart';
// domain -> usecases
export 'domain/usecases/get_tv_detail.dart';
export 'domain/usecases/get_tv_recommendations.dart';
export 'domain/usecases/get_now_playing_tv.dart';
export 'domain/usecases/get_popular_tv.dart';
export 'domain/usecases/get_top_rated_tv.dart';
export 'domain/usecases/get_watchlist_tv.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';
export 'domain/usecases/search_tv.dart';
// domain -> repositories
export 'domain/repositories/tv_repository.dart';

// presentation
// presentation -> pages
export 'presentation/pages/tv_detail_page.dart';
export 'presentation/pages/home_tv_page.dart';
export 'presentation/pages/popular_tv_page.dart';
export 'presentation/pages/top_rated_tv_page.dart';
export 'presentation/pages/watchlist_tv_page.dart';
// presentation -> provider
export 'presentation/provider/tv_detail_notifier.dart';
export 'presentation/provider/tv_list_notifier.dart';
export 'presentation/provider/popular_tv_notifier.dart';
export 'presentation/provider/top_rated_tv_notifier.dart';
export 'presentation/provider/watchlist_tv_notifier.dart';
// presentation -> widgets
export 'presentation/widgets/tv_card_list.dart';