# elasticsearch记录
## 概念
### index 
index 是一个或多个物理分片的组合
### shard
shard 有两种 primary 和 replic。 主分片数在索引创建时固定，副本分片数可以在任何时候修改

## 1.查看集群状态：
    curl -X GET "localhost:9200/_cat/health?v"
## 2.查看节点
    curl -X GET "localhost:9200/_cat/nodes?v"
## 3.列出所有索引
    curl -X GET "localhost:9200/_cat/indices?v"

## 4.创建索引
    curl -X PUT "localhost:9200/customer?pretty"
* `pretty`表示，美化response的格式

## 5.index document
**put和post都可以创建文档（指定id），如果不指定id,则只能使用post**
```
curl -X PUT "localhost:9200/customer/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "name": "John Doe"
}
'
```

## 6.delete an index
    curl -X DELETE "localhost:9200/customer?pretty

使用查询API删除文档
```
curl -X POST "localhost:9200/twitter/_delete_by_query" -H 'Content-Type: application/json' -d'
{
  "query": { 
    "match": {
      "message": "some message"
    }
  }
}
'
```
>如果想计算版本冲突而不是终止查询可以使用`conflicts=proceed`

## 7.update documents
### [1. 根据id更新](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-update.html)

PUT和POST都可以更新文档， 如果已存在该属性就更新，不不存在则新增，PUT会更新文档的全部内容

```
curl -X POST "localhost:9200/test/_doc/1/_update?pretty" -H 'Content-Type: application/json' -d'
{
  "doc": { "name": "Jane Doe" }
}
'
```

 ***可以使用脚本：例如***

添加属性 
```
curl -X POST "localhost:9200/test/_doc/1/_update" -H 'Content-Type: application/json' -d'
{
    "script" : "ctx._source.new_field = \u0027value_of_new_field\u0027"
}
'
```

删除属性
```
curl -X POST "localhost:9200/test/_doc/1/_update" -H 'Content-Type: application/json' -d'
{
    "script" : "ctx._source.remove(\u0027new_field\u0027)"
}
'
```

删除数组中的元素

```
curl -X POST "localhost:9200/test/_doc/1/_update" -H 'Content-Type: application/json' -d'
{
    "script" : {
        "source": "if (ctx._source.tags.contains(params.tag)) { ctx._source.tags.remove(ctx._source.tags.indexOf(params.tag)) }",
        "lang": "painless",
        "params" : {
            "tag" : "blue"
        }
    }
}
'
```

数组追加
```
curl -X POST "localhost:9200/test/_doc/1/_update" -H 'Content-Type: application/json' -d'
    {
    "script" : {
        "source": "if (!ctx._source.tags.contains(params.tag)) { ctx._source.tags.add(params.tag) }",
        "lang": "painless",
        "params" : {
            "tag" : "blue"
        }
    }
}
'
```
添加新属性

```
curl -X POST "localhost:9200/test/_doc/1/_update" -H 'Content-Type: application/json' -d'
{
    "script" : "ctx._source.new_field = \u0027value_of_new_field\u0027"
}
'
```

**如果同时指定doc和script,doc会被忽略**

###### 是否检测无操作 `detect_noop` default is to `true`
更新内容与原来相同

`detect_noop=true`，结果
```
{"_index":"test","_type":"_doc","_id":"1","_version":19,"result":"noop","_shards":{"total":0,"successful":0,"failed":0}}
```
`detect_noop=false` 结果
```
{"_index":"test","_type":"_doc","_id":"1","_version":20,"result":"updated","_shards":{"total":2,"successful":1,"failed":0},"_seq_no":19,"_primary_term":1}
```

### [2. Update By Query API](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-update-by-query.html)
基本格式
```
curl -X POST "localhost:9200/twitter/_update_by_query?conflicts=proceed"
```
它可以用来对文档添加默认值

执行过程

1. 开始时获取快照
2. 比对版本号
3. 更新


`NOTE Since internal versioning does not support the value 0 as a valid version number, documents with version equal to zero cannot be updated using _update_by_query and will fail the request.
不会更新版本号是0的文档
`

版本号冲突不会回滚，如果多次更新都失败，会在`failures`中返回，此时会立刻返回结果。如果想计算版本冲突而不是终止查询可以使用`conflicts=proceed`

使用脚本

```
curl -X POST "localhost:9200/twitter/_update_by_query" -H 'Content-Type: application/json' -d'
{
  "script": {
    "source": "ctx._source.likes++",
    "lang": "painless"
  },
  "query": {
    "term": {
      "user": "kimchy"
    }
  }
}
'
```
使用`ctx.op`在脚本中修改操作 [noop|delete]

多个index,type

    curl -X POST "localhost:9200/twitter,blog/_doc,post/_update_by_query"

#### [url参数](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-update-by-query.html#_url_parameters_2)

#### [Task](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-update-by-query.html#docs-update-by-query-task-api) 查看执行进度

Pick up a new property
```
curl -X PUT "localhost:9200/test" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "_doc": {
      "dynamic": false,   //插入新属性时不会更新mapping,但会在_source中返回
      "properties": {
        "text": {"type": "text"}
      }
    }
  }
}
'
curl -X POST "localhost:9200/test/_doc?refresh" -H 'Content-Type: application/json' -d'
{
  "text": "words words",
  "flag": "bar"
}
'
curl -X POST "localhost:9200/test/_doc?refresh" -H 'Content-Type: application/json' -d'
{
  "text": "words words",
  "flag": "foo"
}
'
curl -X PUT "localhost:9200/test/_mapping/_doc" -H 'Content-Type: application/json' -d'
{
  "properties": {
    "text": {"type": "text"},
    "flag": {"type": "text", "analyzer": "keyword"}
  }
}
'

此时无法通过foo来搜索，必须通过 curl -X POST "localhost:9200/test/_update_by_query?refresh&conflicts=proceed"更新mapping
原话 you can issue an _update_by_query request to pick up the new mapping:

curl -X POST "localhost:9200/test/_search?filter_path=hits.total" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "flag": "foo"
    }
  }
}
'

```

## 8.Multi Get API
会在docs的数组中顺序（请求时的顺序）返回

```
curl -X GET "localhost:9200/_mget" -H 'Content-Type: application/json' -d'
{
    "docs" : [
        {
            "_index" : "test",
            "_type" : "_doc",
            "_id" : "1"
        },
        {
            "_index" : "test",
            "_type" : "_doc",
            "_id" : "2"
        }
    ]
}
'
等于
curl -X GET "localhost:9200/test/_mget" -H 'Content-Type: application/json' -d'
{
    "docs" : [
        {
            "_type" : "_doc",
            "_id" : "1"
        },
        {
            "_type" : "_doc",
            "_id" : "2"
        }
    ]
}
'
等于
curl -X GET "localhost:9200/test/_doc/_mget" -H 'Content-Type: application/json' -d'
{
    "docs" : [
        {
            "_id" : "1"
        },
        {
            "_id" : "2"
        }
    ]
}
'

```
Response
```
{
  "docs" : [
    {
      "_index" : "test",
      "_type" : "_doc",
      "_id" : "1",
      "_version" : 1,
      "_seq_no" : 0,
      "_primary_term" : 1,
      "found" : true,
      "_source" : {
        "name" : "1"
      }
    },
    {
      "_index" : "test",
      "_type" : "_doc",
      "_id" : "2",
      "found" : false
    }
  ]
}
```
[source过滤/不返回](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-multi-get.html#mget-source-filtering)

## 9.批量处理 （_bulk）
The bulk API makes it possible to perform many index/delete operations in a single API call. This can greatly increase the indexing speed.

批量插入， 批量更新（同时更新和删除）当一个失败时会继续执行后面的操作，批量操作返回时会顺序返回结果

1.简单搜索 

* There are two basic ways to run searches: one is by sending search parameters through the REST request URI and the other by sending them through the REST request body.

>URI

    curl -X GET "localhost:9200/bank/_search?q=*&sort=account_number:asc&pretty"
>request body
```
curl -X GET "localhost:9200/bank/_search" -H 'Content-Type: application/json' -d'
{
  "query": { "match_all": {} },
  "sort": [
    { "account_number": "asc" }
  ]
}
'
```
## 10.Reindex
The most basic form of `_reindex` just copies documents from one index to another. This will copy documents from the `twitter` index into the `new_twitter` index:

相当于数据复制
```
curl -X POST "localhost:9200/_reindex" -H 'Content-Type: application/json' -d'
{
  "source": {
    "index": "twitter"
  },
  "dest": {
    "index": "new_twitter"
  }
}
'
```
**根据快照**

## 11.搜索
#### 路由
#### 自适应副本选择
默认时副本之间轮询

开启
```
curl -X PUT "localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
{
    "transient": {
        "cluster.routing.use_adaptive_replica_selection": true
    }
}
'
```
开启之后会根据节点队列中线程数等来自适应选择最佳副本

#### 全局的搜索超时时间
`search.default_search_timeout`

#### 搜索类型
`search_type` [`query_then_fetch`|`dfs_query_then_fetch`] defaults to `query_then_fetch`

每一次的搜索都是一个分散/聚合的过程（scatter/gather）,`query_then_fetch`和`dfs_query_then_fetch`描述的就是两种不同的分散/聚合过程的解决方案

然而这其中有两个问题：

* 第一个问题就是，当我们需要搜索某一条件的前十条数据时，需要把请求分散到各个分片上去执行，然后取回这些结果，并处理（如排序）。这样做增加带宽压力
* 第二个问题就是，每个分片都是独立的，由他自己的词频和信息，搜索时是根据这些信息进行排序的。如果需要精确的排序，必须先从各个分片获取词频等信息，然后在执行搜索操作

`query_then_fetch`解决了第一个问题，`dfs_query_then_fetch`解决了第二个问题，当然`dfs_query_then_fetch`是基于第一个问题的

`query_then_fetch`
```
The request is processed in two phases. In the first phase, the query is forwarded to all involved shards. 
Each shard executes the search and generates a sorted list of results, local to that shard. Each shard returns 
just enough information to the coordinating node to allow it merge and re-sort the shard level results into a 
globally sorted set of results, of maximum length size.

During the second phase, the coordinating node requests the document content (and highlighted snippets, if any) 
from only the relevant shards.
分两步查询，第一步只拿回相关的需要处理的信息（如排序），第二部只查询相关分片的数据
```
`dfs_query_then_fetch`
```
Same as "Query Then Fetch", except for an initial scatter phase which goes and computes the distributed term 
frequencies for more accurate scoring.
```
**如果排序是不重要的可以将sort设置为`_doc`**

#### 查询索引中文档数量

#### [排序](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-sort.html)
基本格式：
```
curl -X GET "localhost:9200/my_index/_search" -H 'Content-Type: application/json' -d'
{
    "sort" : [
        { "post_date" : {"order" : "asc"}},
        "user",
        { "name" : "desc" },
        { "age" : "desc" },
        "_score"
    ],
    "query" : {
        "term" : { "user" : "kimchy" }
    }
}
'
```

`_doc`:不关心排序
```
{
    "sort": [
        "_doc"
    ]
}
```

`mode`: 用户数组field. [`min`|`max`|`sum`|`avg`|`median`]

嵌套field排序

`missing`：当该field没值时的排序，默认`_last`
```
curl -X GET "localhost:9200/_search" -H 'Content-Type: application/json' -d'
{
    "sort" : [
        { "price" : {"missing" : "_last"} }
    ],
    "query" : {
        "term" : { "product" : "chocolate" }
    }
}
'
```
`unmapped_type`:如果mapping里没有该field,不加`unmapped_type`会报错

##### Geo排序
如果field的值为空，默认距离无穷大

##### 自定义脚本

**默认情况下排序时`_score`不会被计算，如果此时还要计算使用`track_scores`**

##### post_filter
可以在聚合之后执行的过滤器
##### 内存
```
When sorting, the relevant sorted field values are loaded into memory. This means that per shard,
there should be enough memory to contain them. For string based types, the field sorted on should
not be analyzed / tokenized. For numeric types, if possible, it is recommended to explicitly set the
type to narrower types (like short, integer and float).
```

#### 脚本字段(script_fields)
doc['my_field'].value and params['_source']['my_field'] 区别？

第一个速度快，但是耗内存，仅支持简单的取值，无法取对象，仅对非分析或基于单个术语的领域有意义（makes sense only for non-analyzed or single term based fields），推荐

_source 因为_source必须在每次使用时加载和解析。使用_source非常慢。

#### rescore (再打分)

#### preference

#### explain
```
GET /_search
{
    "explain": true,
    "query" : {
        "term" : { "user" : "kimchy" }
    }
}
```
#### collapse (字段折叠/展开) 超级使用的功能
可以理解就是按特定字段进行合并去重

配合inner_hits,可以获取分组前N条数据
```
GET post/_search
{
    "query" : {
        "term" : { "delFlag": 1 }
    },
    "collapse": {
      "field": "postType",
      "inner_hits": {
            "name": "last_tweets", 
            "size": 2, 
            "sort": [{ "createTime": "asc" }] 
        }
    }
}
```

#### search_after
实时分页使用

from/size 有局限，如果`from + size `不能大于`index.max_result_window` 默认10000

#### [_msearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-multi-search.html)
```
GET _msearch
{"index":"post"} //header
{"query": {"match_all": {}}, "from": 0, "size": 2}//body
{"index" : "test"}//header
{"query" : {"match_all" : {}}}//body
```
注意事项：

1. 必须严格按照格式：header和body成对出现，且结尾处显式追加\n（回车）。
2. 每个header和body都仅占一行，否则会报错，因为ES是通过\n（回车）来识别语句的。
3. header不可省略，即使内容为空，也要显式写上{}并追加\n（回车）表示本行结束。
4. 在最后一个body结尾处，容易忘记追加一个\n，从而导致最后一个查询未执行。

#### count 返回数量
和普通的搜索一样，只是endpoint由_search改为_count

也可以查询多个索引 （Multi index）

post/get都支持

#### _validate/query
检查查询语句有没有错误

加上`explain=true`可以返回为什么查询语句错误

_validate/query?explain=true

当`rewrite=true`时，会更详细的展示查询再lucene中查询

默认情况下只在多个分片中随机选择一个分片进行操作。查询的详细说明可能取决于正在命中哪个分片，因此可能会因请求而异。

因此，在查询重写的情况下，应使用`all_shards`参数从所有可用分片获取响应。
```
GET twitter/_doc/_validate/query?rewrite=true&all_shards=true
{
  "query": {
    "match": {
      "user": {
        "query": "kimchy",
        "fuzziness": "auto"
      }
    }
  }
}
```

#### _explain score由来
explain api计算查询和特定文档的分数说明。无论文档是否与特定查询匹配，这都可以提供有用的反馈。
```
GET /post/_search?explain=true
{
  "query": {
    "match": {
      "title": "地板"
    }
  }
}
```
## 未完

## 聚合
    聚合框架有助于基于搜索查询提供聚合数据。它基于称为聚合的简单构建块，可以组合以构建复杂的数据摘要。

    聚合可以被看作时在一组文档上建立分析信息的工作单元。执行的上下文定义了这些文档的内容。也就是说聚合嵌套时是一级一级进行分析的。

聚合分为四大家族 

基本结构
```
"aggregations" : {
    "<aggregation_name>" : {
        "<aggregation_type>" : {
            <aggregation_body>
        }
        [,"meta" : {  [<meta_data_body>] } ]?
        [,"aggregations" : { [<sub_aggregation>]+ } ]?
    }
    [,"<aggregation_name_2>" : { ... } ]*
}
```

## 12.分析
#### 搜索时的分析器顺序
```
Specifying a search time analyzeredit
Usually the same analyzer should be used both at index time and at search time, and full text queries like the match query will use the mapping to look up the analyzer to use for each field.

The analyzer to use to search a particular field is determined by looking for:

1.An analyzer specified in the query itself.
2.The search_analyzer mapping parameter.
3.The analyzer mapping parameter.
4.An analyzer in the index settings called default_search.
5.An analyzer in the index settings called default.
6.The standard analyzer.
```


---

---
**重要内容：**

1.可以通过增加副本的数目来提升查询性能

2.副本数 + 1 <= 节点数 <= 分片数 *（副本数 + 1）

3.各节点上分片数（包括主分片和副本分片）最好均衡分配
比如两个节点，总分片数最好是2，4，6，如果是三个节点，总分数最好是3，6，9，可以修改分片数和副本数来调整

4.修改索引的副本数量
```
PUT /my_index/_settings
{
  "number_of_replicas": 2
}
```

5.Routing 路由
默认是计算id的hash值，可以指定
```
curl -X POST "localhost:9200/twitter/_doc?routing=kimchy" -H 'Content-Type: application/json' -d'
{
    "user" : "kimchy",
    "post_date" : "2009-11-15T14:12:12",
    "message" : "trying out Elasticsearch"
}
'
```
* **自定义路由可以使查询更快速，因为插入时我们是知道document在哪一个分片的，所以查询指定分片查询就可以
所有的文档API（get，index，delete，update和mget）都能接收一个routing参数，可以用来形成个性化文档分片映射**

6.elasticsearch 如何保持文档的乐观并发 （主备）

elatisearch是分布式的，当创建，更新，删除文档时，都会同步集群中的其他副本中。这些操作时异步的并发的，也就是说这些操作时并行发生的，并且到达的顺序也是不确定的。
这样就会导致一个情况，旧的操作在新操作后执行。

为了确保以上旧操作不会覆盖新操作，elasticsearc会在各个操作中放一个序列号（由主分片协调）

**重要参数：**

##### 1.插入

* `wait_for_active_shards` 默认值：1 只要主分片已完成就立即返回成功

##### 2.查询
* `realtime` 是否近实时

* `_source`  

>返回时是否包含`_source`属性，默认`true`,

>`_source_includes` 返回包含那些属性，多个逗号隔开

>`_source_excludes` 返回去除那些属性，多个逗号隔开

>当只想指定包含时，`_source_includes = _source`

>只返回_source的内容 ```curl -X GET "localhost:9200/twitter/_doc/1/_source"```

* `stored_field`

* `preference` [_primary|_local|自定义的值（string）]

>**如不设置该参数：在所有有效的主分片以及副本间轮询**

---

---
## 随笔

### 1.refresh

 作用： 使更新，删除，插入对查询可见

>`true` 每次都刷新，慎用，确保对性能没影响

>`false` 

>`wait_for` 等待更新。默认是1秒i.g. 操作后会等待1秒然后刷新，但是他会影响返回的时间。 通过index.refresh_interval设置。不支持在查询API中使用该值

### 2. must_not 相当于 filter，不参与评分












