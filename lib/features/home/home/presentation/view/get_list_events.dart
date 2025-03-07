import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turn_digital/core/constant/colors_code.dart';
import 'package:turn_digital/core/theme/texts_styles.dart';
import '../../../../../core/constant/assets_path.dart';
import '../../cubit/event_cubit.dart';
import '../../cubit/event_state.dart';
import '../../data/event_model.dart';
import '../widgets/build_shimmer_effect.dart';
import '../widgets/event_card_list.dart';
import 'event_details_screen.dart';

class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  _EventsListScreenState createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  late EventCubit _eventCubit;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  List<Event> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _eventCubit = context.read<EventCubit>();
    _eventCubit.fetchEvents(isRefresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        _eventCubit.fetchEvents();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        _searchController.clear();
        filteredEvents = _eventCubit.events;
      }
    });
  }

  void _filterEvents(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredEvents = _eventCubit.events;
      });
      return;
    }

    setState(() {
      filteredEvents = _eventCubit.events
          .where((event) => event.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_eventCubit.events.isEmpty) {
      _eventCubit.fetchEvents(isRefresh: true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.CWhite,
      appBar: AppBar(
        backgroundColor: AppColors.CWhite,
        title: isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search events...",
            border: InputBorder.none,
          ),
          onChanged: _filterEvents,
        )
            : Text("Events", style: AppTextStyles.font20DarkLight,),
        leading: Bounce(
          onTap: () {
            if (isSearching) {
              _toggleSearch();
            } else {
              Navigator.pop(context);
            }
          },
          child: SvgPicture.asset(
            AssetsPATH.iArrowLeft,
            fit: BoxFit.scaleDown,
            width: 24.w,
            height: 24.h,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              children: [
                Bounce(
                  onTap: _toggleSearch,
                  child: SvgPicture.asset(
                    isSearching ? AssetsPATH.iCloseDark : AssetsPATH.iSearchDark,
                    fit: BoxFit.scaleDown,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  AssetsPATH.iMenuDots,
                  fit: BoxFit.scaleDown,
                  width: 24.w,
                  height: 24.h,
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoading && _eventCubit.events.isEmpty) {
            return buildShimmerEffect();
          } else if (state is EventError) {
            return Center(child: Text(state.message));
          } else if (state is EventLoaded) {
            final events = isSearching ? filteredEvents : state.events;

            return ListView.builder(
              controller: _scrollController,
              itemCount: events.length + 1,
              itemBuilder: (context, index) {
                if (index == events.length) {
                  return _eventCubit.hasMore ? buildShimmerEffect() : SizedBox();
                }

                final event = events[index];
                return Bounce(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (newContext) => BlocProvider(
                          create: (context) => EventCubit()..fetchEventById(event.eventId),
                          child: EventDetailsScreen(eventId: event.eventId),
                        ),
                      ),
                    );

                  },
                  child: EventCardList(
                    eventImage: event.picture,
                    eventTitle: event.title,
                    eventDate: event.date,
                    attendees: [event.organizer.picture],
                    eventLocation: event.address,
                    numberOfGoing: event.numberOfGoing,
                  ),
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
