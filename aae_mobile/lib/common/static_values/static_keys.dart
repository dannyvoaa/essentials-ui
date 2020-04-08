/// This file contains the static id keys for storing and caching purposes
/// [workgroupCacheKey] this key would allow us to read and write data to
/// [CacheService] to be consumed by [WorkgroupsSelectionBloc] and
/// [ModifyPreferenceBloc].
final String workgroupCacheKey = 'selected-workgroup';

/// [topicsCacheKey] this key would allow us to read and write data to
/// [CacheService] to be consumed by [TopicsSelectionBloc] and
/// [ModifyPreferenceBloc].
final String topicsCacheKey = 'selected-topics';

//TODO (rpaglinawan): add in the apiKey once available
final String apiKey = '';
