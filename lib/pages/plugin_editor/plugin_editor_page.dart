import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kazumi/plugins/plugins.dart';
import 'package:kazumi/plugins/plugins_controller.dart';
import 'package:kazumi/bean/appbar/sys_app_bar.dart';

class PluginEditorPage extends StatefulWidget {
  const PluginEditorPage({
    super.key,
  });

  @override
  State<PluginEditorPage> createState() => _PluginEditorPageState();
}

class _PluginEditorPageState extends State<PluginEditorPage> {
  final PluginsController pluginsController = Modular.get<PluginsController>();
  final TextEditingController apiController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController versionController = TextEditingController();
  final TextEditingController userAgentController = TextEditingController();
  final TextEditingController baseURLController = TextEditingController();
  final TextEditingController searchURLController = TextEditingController();
  final TextEditingController searchListController = TextEditingController();
  final TextEditingController searchNameController = TextEditingController();
  final TextEditingController searchImgController = TextEditingController();
  final TextEditingController searchResultController = TextEditingController();
  final TextEditingController chapterRoadsController = TextEditingController();
  final TextEditingController chapterItemsController = TextEditingController();
  final TextEditingController chapterResultController = TextEditingController();
  final TextEditingController chapterResultNameController =
      TextEditingController();
  final TextEditingController refererController = TextEditingController();

  final Map<String, String> _editedTags = {};
  final TextEditingController _tagKeyController = TextEditingController();
  final TextEditingController _tagValueController = TextEditingController();

  bool muliSources = true;
  bool useWebview = true;
  bool useNativePlayer = false;
  bool usePost = false;
  bool useLegacyParser = false;

  @override
  void initState() {
    super.initState();
    final Plugin plugin = Modular.args.data as Plugin;
    apiController.text = plugin.api;
    typeController.text = plugin.type;
    nameController.text = plugin.name;
    versionController.text = plugin.version;
    userAgentController.text = plugin.userAgent;
    baseURLController.text = plugin.baseUrl;
    searchURLController.text = plugin.searchURL;
    searchListController.text = plugin.searchList;
    searchNameController.text = plugin.searchName;
    searchImgController.text = plugin.searchImg;
    searchResultController.text = plugin.searchResult;
    chapterRoadsController.text = plugin.chapterRoads;
    chapterItemsController.text = plugin.chapterItems;
    chapterResultController.text = plugin.chapterResult;
    chapterResultNameController.text = plugin.chapterResultName;
    refererController.text = plugin.referer;
    muliSources = plugin.muliSources;
    useWebview = plugin.useWebview;
    useNativePlayer = plugin.useNativePlayer;
    usePost = plugin.usePost;
    useLegacyParser = plugin.useLegacyParser;
    _editedTags.addAll(plugin.tags);
  }

  @override
  Widget build(BuildContext context) {
    final Plugin plugin = Modular.args.data as Plugin;

    return Scaffold(
      appBar: const SysAppBar(
        title: Text('规则编辑器'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: (MediaQuery.of(context).size.width > 1000) ? 1000 : null,
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('内置播放器'),
                  subtitle: const Text('调试时保持禁用'),
                  value: useNativePlayer,
                  onChanged: (bool value) {
                    setState(() {
                      useNativePlayer = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: versionController,
                  decoration: const InputDecoration(
                      labelText: 'Version', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: baseURLController,
                  decoration: const InputDecoration(
                      labelText: 'BaseURL', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: searchURLController,
                  decoration: const InputDecoration(
                      labelText: 'SearchURL', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: searchListController,
                  decoration: const InputDecoration(
                      labelText: 'SearchList', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: searchNameController,
                  decoration: const InputDecoration(
                      labelText: 'SearchName', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: searchImgController,
                  decoration: const InputDecoration(
                      labelText: 'SearchImg', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: searchResultController,
                  decoration: const InputDecoration(
                      labelText: 'SearchResult', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: chapterRoadsController,
                  decoration: const InputDecoration(
                      labelText: 'ChapterRoads', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: chapterItemsController,
                  decoration: const InputDecoration(
                      labelText: 'ChapterItems', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: chapterResultController,
                  decoration: const InputDecoration(
                      labelText: 'ChapterResult', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: chapterResultNameController,
                  decoration: const InputDecoration(
                      labelText: 'ChapterResultName',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text('标签管理'),
                  initiallyExpanded: true,
                  children: [
                    const SizedBox(height: 10),
                    _buildTagEditor(),
                    const SizedBox(height: 10),
                    _buildTagList(),
                  ],
                ),
                ExpansionTile(
                  title: const Text('高级选项'),
                  children: [
                    SwitchListTile(
                      title: const Text('简易解析'),
                      subtitle: const Text('使用简易解析器而不是现代解析器'),
                      value: useLegacyParser,
                      onChanged: (bool value) {
                        setState(() {
                          useLegacyParser = value;
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text('POST'),
                      subtitle: const Text('使用POST而不是GET进行检索'),
                      value: usePost,
                      onChanged: (bool value) {
                        setState(() {
                          usePost = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: userAgentController,
                      decoration: const InputDecoration(
                          labelText: 'UserAgent', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: refererController,
                      decoration: const InputDecoration(
                          labelText: 'Referer', border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          plugin.api = apiController.text;
          plugin.type = apiController.text;
          plugin.name = nameController.text;
          plugin.version = versionController.text;
          plugin.userAgent = userAgentController.text;
          plugin.baseUrl = baseURLController.text;
          plugin.searchURL = searchURLController.text;
          plugin.searchList = searchListController.text;
          plugin.searchName = searchNameController.text;
          plugin.searchImg = searchImgController.text;
          plugin.searchResult = searchResultController.text;
          plugin.chapterRoads = chapterRoadsController.text;
          plugin.chapterItems = chapterItemsController.text;
          plugin.chapterResult = chapterResultController.text;
          plugin.chapterResultName = chapterResultNameController.text;
          plugin.muliSources = muliSources;
          plugin.useWebview = useWebview;
          plugin.useNativePlayer = useNativePlayer;
          plugin.usePost = usePost;
          plugin.useLegacyParser = useLegacyParser;
          plugin.referer = refererController.text;
          plugin.tags.clear();
          plugin.tags.addAll(_editedTags);
          pluginsController.updatePlugin(plugin);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildTagEditor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: _tagKeyController,
              decoration: const InputDecoration(
                labelText: 'key',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 7,
            child: TextField(
              controller: _tagValueController,
              decoration: const InputDecoration(
                labelText: 'value',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (_tagKeyController.text.isNotEmpty &&
                  _tagValueController.text.isNotEmpty) {
                setState(() {
                  _editedTags[_tagKeyController.text] = _tagValueController.text;
                  _tagKeyController.clear();
                  _tagValueController.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // 修改 _buildTagList 方法
  Widget _buildTagList() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      child: ListView(
        shrinkWrap: true,
        children: _editedTags.entries.map((entry) => ListTile(
          title: Text('${entry.key}: ${entry.value}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditTagDialog(entry.key, entry.value),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() => _editedTags.remove(entry.key));
                },
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

// 添加新的编辑标签对话框方法
  void _showEditTagDialog(String oldKey, String oldValue) {
    final TextEditingController keyController = TextEditingController(text: oldKey);
    final TextEditingController valueController = TextEditingController(text: oldValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑tag'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyController,
              decoration: const InputDecoration(
                labelText: 'key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'value',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final newKey = keyController.text.trim();
              final newValue = valueController.text.trim();

              if (newKey.isNotEmpty && newValue.isNotEmpty) {
                setState(() {
                  // 处理键修改的情况
                  if (newKey != oldKey) {
                    _editedTags.remove(oldKey);
                  }
                  _editedTags[newKey] = newValue;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

}
