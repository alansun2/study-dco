# Table of Contents

* [Spring框架概述](#spring框架概述)
  * [1.“spring”是什么意思](#1spring是什么意思)
  * [2.spring框架的历史](#2spring框架的历史)
  * [3.设计原则](#3设计原则)
  * [4.反馈和贡献](#4反馈和贡献)
  * [5.开始](#5开始)
* [核心技术](#核心技术)
  * [1. The IoC Container](#1-the-ioc-container)
    * [1.1 Spring容器和Beans简介](#11-spring容器和beans简介)
    * [1.2 容器概览](#12-容器概览)
      * [1.2.1 配置元数据](#121-配置元数据)
      * [1.2.2 实例化容器](#122-实例化容器)
      * [1.2.3 使用容器](#123-使用容器)
    * [1.3 Bean概览](#13-bean概览)
      * [1.3.1 bean的命名](#131-bean的命名)
      * [1.3.2 实例化bean](#132-实例化bean)
    * [1.4 依赖](#14-依赖)
      * [1.4.1 依赖注入](#141-依赖注入)
        * [1.基于构造器注入（Constructor-based Dependency Injection）](#1基于构造器注入（constructor-based-dependency-injection）)
        * [构造器参数解决方案（Constructor Argument Resolution）](#构造器参数解决方案（constructor-argument-resolution）)
        * [2.基于set的注入（Setter-based Dependency Injection）](#2基于set的注入（setter-based-dependency-injection）)
        * [依赖解决过程](#依赖解决过程)
        * [依赖注入的示例](#依赖注入的示例)
      * [1.4.2 依赖关系和配置的细节](#142-依赖关系和配置的细节)
        * [直值（基元，字符串等）(Straight Values (Primitives, Strings, and so on))](#直值（基元，字符串等）straight-values-primitives-strings-and-so-on)
        * [The idref element](#the-idref-element)
        * [参考其他bean（合作者（被注入的依赖bean））](#参考其他bean（合作者（被注入的依赖bean））)
        * [Inner Beans (内部类)](#inner-beans-内部类)
        * [集合](#集合)
        * [集合合并](#集合合并)
        * [强类型集合（Strongly-typed collection）](#强类型集合（strongly-typed-collection）)
        * [NULL值和空字符串值](#null值和空字符串值)
        * [带有p命名空间的XML快捷方式](#带有p命名空间的xml快捷方式)
        * [带有c命名空间的XML快捷方式 （构造方法）](#带有c命名空间的xml快捷方式-（构造方法）)
        * [复合属性名称 （Compound Property Names）](#复合属性名称-（compound-property-names）)
        * [使用`depends-on`](#使用`depends-on`)
        * [延迟加载](#延迟加载)
      * [1.4.5 自动装配依赖(Autowiring Collaborators)](#145-自动装配依赖autowiring-collaborators)
        * [自动装配的局限和缺点](#自动装配的局限和缺点)
          * [从自动装配中排除Bean](#从自动装配中排除bean)
      * [1.4.6 方法注入](#146-方法注入)
        * [查找方法注入](#查找方法注入)
        * [任意方法替换](#任意方法替换)
    * [1.5 Bean范围 （Bean Scopes）](#15-bean范围-（bean-scopes）)
      * [1.5.1 单例](#151-单例)
      * [1.5.2 The Prototype Scope](#152-the-prototype-scope)
      * [1.5.3 单例bean依赖原型bean](#153-单例bean依赖原型bean)
      * [1.5.4 请求，会话，应用程序和WebSocket范围](#154-请求，会话，应用程序和websocket范围)
        * [Initial Web Configuration](#initial-web-configuration)
        * [Request scope](#request-scope)
        * [Session Scope](#session-scope)
        * [Application Scope](#application-scope)
        * [作为依赖关系的Scoped Bean (Scoped Beans as Dependencies)](#作为依赖关系的scoped-bean-scoped-beans-as-dependencies)
        * [Choosing the Type of Proxy to Create](#choosing-the-type-of-proxy-to-create)
      * [1.5.5 自定义范围](#155-自定义范围)
        * [创建自定义范围](#创建自定义范围)
        * [使用自定义范围](#使用自定义范围)
    * [1.6 定制Bean的本质](#16-定制bean的本质)



# Spring框架概述
spring是一个轻量的java企业级应用开发框架，它提供了开发Java企业级应用的一切，同时支持Groovy和Kotlin，可根据应用程序的需要灵活地创建多种体系结构。spring5.1后最低支持到jdk8而且为jdk11提供了开箱即用。

## 1.“spring”是什么意思
"spring"在不同的情况下表达不同的意思。它可以用来引用Spring Framework框架本身，它就是一切开始的地方。随着时间的推移，其他Spring项目已经构建在Spring Framework之上（比如springboot，spring-cloud）。大多数情况下，我们说“spring”
它是指整个整个spring家族。**此参考文档是基于该基础：Spring Framework本身（不包括如spring-boot等）**。

Spring Framework被拆成了多个模块。应用可以选择他们需要的模块。核心容器模块包括**配置模型（configuration model）**和**依赖注入机制（dependency injection mechanism）**。除此之外，Spring Framework也为不同的应用提供了基础的
支持，包括消息，事务，持久化，和web开发。它还包括了基于Servlet的`Spring MVC`web框架，并行，`Spring WebFlux`响应式web框架。

*关于模块的说明*：Spring的框架jar允许部署到JDK 9的模块路径（“Jigsaw”）。
```
A note about modules: Spring’s framework jars allow for deployment to JDK 9’s module path ("Jigsaw"). 
For use in Jigsaw-enabled applications, the Spring Framework 5 jars come with "Automatic-Module-Name"
 manifest entries which define stable language-level module names ("spring.core", "spring.context" etc) 
 independent from jar artifact names (the jars follow the same naming pattern with "-" instead of ".", 
 e.g. "spring-core" and "spring-context"). Of course, Spring’s framework jars keep working fine on the 
 classpath on both JDK 8 and 9+.
```

## 2.spring框架的历史
## 3.设计原则
## 4.反馈和贡献
## 5.开始

# 核心技术
这部分参考文档涵盖了Spring Framework绝对不可或缺的所有技术。

其中最重要的是Spring Framework的控制反转（IoC）容器。Spring框架的IoC容器的全面处理紧随其后，全面覆盖了Spring的面向切面编程（AOP）技术。Spring有自己的AOP框架，这在概念上很容易理解，它成功地解决了Java企业编程中AOP要求的80％
最佳点。

还提供了Spring与AspectJ（目前最丰富的 - 在功能方面 - 当然也是Java企业领域中最成熟的AOP实现）集成的覆盖范围。

## 1. The IoC Container
This chapter covers Spring’s Inversion of Control (IoC) container.

### 1.1 Spring容器和Beans简介
本章介绍了控制反转（IoC）原理的Spring Framework实现。总所周知，ioc就是依赖注入。这是一个过程，通过这个过程，对象只能通过构造函数参数，工厂方法的参数或在构造或从工厂方法返回后在对象实例上设置的属性来定义它们的依赖关系（即，它
们使用的其他对象）。然后容器在创建bean时注入这些依赖项。此过程基本上是bean本身的逆（因此名称，控制反转），通过使用类的直接构造或诸如服务定位器模式的机制来控制其依赖关系的实例化或位置。（This process is fundamentally the
 inverse (hence the name, Inversion of Control) of the bean itself controlling the instantiation or location of its dependencies by using direct construction of classes or a mechanism such as the Service 
 Locator pattern.）

`org.springframework.beans`和`org.springframework.context`是spring ioc容器的基础。`BeanFactory`接口提供了一种能够管理任何类型对象的高级配置机制。`ApplicationContext`是`BeanFactory`的子接口。它（`ApplicationContext`）
增加了:

* 更容易与Spring的AOP功能集成
* 消息资源处理（用于国际化）
* 时间发布
* 特定于应用程序层的上下文，例如WebApplicationContext，用于Web应用程序。

简而言之，BeanFactory提供了配置框架和基本功能，ApplicationContext添加了更多特定于企业的功能。`ApplicationContext`是`BeanFactory`的完整超集，在本章中仅用于Spring的IoC容器的描述。有关使用`BeanFactory`而不是
`ApplicationContext`的更多信息，请参阅[`The BeanFactory`](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-beanfactory)。

**在Spring中，构成应用程序主干并由Spring IoC容器管理的对象称为bean。bean是一个由Spring IoC容器实例化，组装和管理的对象。另外，bean只是应用程序中许多对象之一。 Bean及其之间的依赖关系反映在容器使用的配置元数据中。**

### 1.2 容器概览
`org.springframework.context.ApplicationContext`接口表示Spring IoC容器，负责实例化，配置和组装bean。容器通过读取配置元数据获取有关要实例化，配置和组装的对象的信息。**配置元数据以XML，Java注解(@Service等)或Java代码表示（@Bean）。**
它允许您表达组成应用程序的对象以及这些对象之间丰富的相互依赖性。

Spring提供了`ApplicationContext`接口的几个实现。在独立应用程序中，通常会创建`ClassPathXmlApplicationContext`或`FileSystemXmlApplicationContext的实例。虽然XML是定义配置元数据的传统格式，但您可以通过提供少量XML配置来声明容器使用Java注释或代码作为元数据格式，以声明方式启用对这些其他元数据格式的支持。

在大多数应用场景中，不需要显式用户代码来实例化Spring IoC容器的一个或多个实例。例如，在Web应用程序场景中，应用程序的web.xml文件中的简单八行（左右）样板Web描述符XML通常就足够了。If you use the Spring Tool Suite 
(an Eclipse-powered development environment), you can easily create this boilerplate configuration with a few mouse clicks or keystrokes.

下图显示了Spring如何工作的高级视图。您的应用程序类与配置元数据相结合，以便在创建和初始化ApplicationContext之后，您拥有一个完全配置且可执行的系统或应用程序。

![Figure 1. The Spring IoC container](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/images/container-magic.png "Figure 1. The Spring IoC container")

#### 1.2.1 配置元数据
如上图所示，Spring IoC容器使用一种配置元数据。此配置元数据表示您作为应用程序开发人员如何告诉Spring容器在应用程序中实例化，配置和组装对象。

传统上，配置元数据以简单直观的XML格式提供，本章大部分内容都是用xml的格式传达Spring IoC容器的关键概念和功能。

>基于XML的元数据不是唯一允许的配置元数据形式。Spring IoC容器本身完全与实际编写此配置元数据的格式分离。目前，许多开发人员为其Spring应用程序选择[基于Java](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-java)的配置。

有关在Spring容器中使用其他形式的元数据的信息，请参阅：

* [基于注解的配置](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-annotation-config)： Spring 2.5引入了对基于注释的配置元数据的支持。
* [基于Java代码的配置](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-java)：从Spring 3.0开始，Spring JavaConfig项目提供的许多功能都成为核心Spring Framework的一部分。
因此，您可以使用Java而不是XML文件在应用程序类外部定义bean。To use these new features, see the @Configuration, @Bean, @Import, and @DependsOn annotations.

Spring配置包含容器必须管理的至少一个且通常不止一个bean定义。基于xml的元数据配置，通过将`<bean/>`定义在`<beans/>`的顶级的方法配置。Java配置通常在`@Configuration`类中使用`@Bean`注解的方法。

这些bean定义对应于构成应用程序的实际对象。通常，您定义服务层对象，数据访问对象（DAO），表示对象（如Struts Action实例），基础结构对象（如Hibernate `SessionFactories`，JMS `Queues`等）。通常，不会在容器中配置细粒度域对象，
因为DAO和业务逻辑通常负责创建和加载域对象。但是，您可以使用Spring与AspectJ的集成来配置在IoC容器控制之外创建的对象。see [Using AspectJ to dependency-inject domain objects with Spring](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#aop-atconfigurable)。

以下示例显示了基于XML的配置元数据的基本结构：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="..." class="..."> 1,2
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <bean id="..." class="...">
        <!-- collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions go here -->

</beans>
```
* id属性是一个标识单个bean定义的字符串。
* class属性定义bean的类型并使用完全限定的classname。

The value of the id attribute refers to collaborating objects. The XML for referring to collaborating objects is not shown in this example. See Dependencies for more information.

#### 1.2.2 实例化容器
提供给ApplicationContext构造函数的位置路径是资源字符串，它允许容器从各种外部资源（如本地文件系统，Java CLASSPATH等）加载配置元数据。
```
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");
```

> 在了解了Spring的IoC容器之后，您可能想要了解有关Spring的[Resource](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources)抽象的更多信息（如参考资料中所述）,它提供了一种方便的机制，用于从URI语法中定义的位置读取InputStream。特别是，资源路径用于构建应用程序上下文，如[应用程序上下文和资源路径](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources-app-ctx)中所述。

以下示例显示了服务层对象（services.xml）配置文件：

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <!-- services -->

    <bean id="petStore" class="org.springframework.samples.jpetstore.services.PetStoreServiceImpl">
        <property name="accountDao" ref="accountDao"/>
        <property name="itemDao" ref="itemDao"/>
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions for services go here -->

</beans>
```

以下示例显示了数据访问对象daos.xml文件：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="accountDao"
        class="org.springframework.samples.jpetstore.dao.jpa.JpaAccountDao">
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <bean id="itemDao" class="org.springframework.samples.jpetstore.dao.jpa.JpaItemDao">
        <!-- additional collaborators and configuration for this bean go here -->
    </bean>

    <!-- more bean definitions for data access objects go here -->

</beans>
```

在前面的示例中，服务层由`PetStoreServiceImpl`类和`JpaAccountDao`和`JpaItemDao`类型的两个数据访问对象组成（基于JPA对象关系映射标准）。属性`name`元素引用JavaBean属性的名称，`ref`元素引用另一个bean定义的名称。 
`id`和`ref`元素之间的这种联系表达了协作对象（各个由spring容器创建的对象）之间的依赖关系。有关配置对象的依赖关系的详细信息，请参[Dependencies](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-dependencies)

<font size="5">编写基于XML的配置元数据</font>

让bean定义跨越多个XML文件会很有用。通常，每个单独的XML配置文件都代表架构中的逻辑层或模块。

您可以使用应用程序上下文构造函数从所有这些XML片段加载bean定义。您可以使用应用程序上下文构造函数从所有这些XML片段加载bean定义。此构造函数采用多个Resource位置，如上一节中所示。或者，使用一个或多个`<import/>`元素来
从另一个或多个文件加载bean定义。如：
```
<beans>
    <import resource="services.xml"/>
    <import resource="resources/messageSource.xml"/>
    <import resource="/resources/themeSource.xml"/>

    <bean id="bean1" class="..."/>
    <bean id="bean2" class="..."/>
</beans>
```
在前面的示例中，外部bean定义从三个文件加载：`services.xml`，`messageSource.xml`和`themeSource.xml`。所有位置路径都相对于执行导入的定义文件，所以`services.xml`必须与执行导入的文件位于同一目录或类路径位置，
而messageSource.xml和themeSource.xml必须位于导入文件位置下方的`resources`中。**如您所见，忽略前导斜杠。但是，鉴于这些路径是相对的，最好不要使用斜杠。**
根据Spring Schema，正在导入的文件的内容（包括顶级`<beans />`元素）必须是有效的XML bean定义。

> 可以（但不建议）使用相对“../”路径引用父目录中的文件。这样做会对当前应用程序之外的文件创建依赖关系。特别是，不建议对classpath使用此引用：URL（例如，classpath：../ services.xml），其中运行时解析过程选择“最近的”类路径根，然后查看其父目录。类路径配置更改可能导致选择不同的，不正确的目录。
> 您始终可以使用完全限定的资源位置而不是相对路径：例如，file：C：/config/services.xml或classpath：/config/services.xml。但是，请注意您将应用程序的配置与特定的绝对位置耦合。通常最好为这些绝对位置保持间接 - 例如，通过在运行时针对JVM系统属性解析的“$ {...}”占位符。

命名空间本身提供了import指令功能。除了普通bean定义之外的其他配置功能在Spring提供的一系列XML命名空间中可用 - 例如，`context`和`util`命名空间。

<font size="5">The Groovy Bean Definition DSL</font>
```
beans {
    dataSource(BasicDataSource) {
        driverClassName = "org.hsqldb.jdbcDriver"
        url = "jdbc:hsqldb:mem:grailsDB"
        username = "sa"
        password = ""
        settings = [mynew:"setting"]
    }
    sessionFactory(SessionFactory) {
        dataSource = dataSource
    }
    myService(MyService) {
        nestedBean = { AnotherBean bean ->
            dataSource = dataSource
        }
    }
}
```

此配置样式在很大程度上等同于XML bean定义，甚至支持Spring的XML配置命名空间。它还允许通过importBeans指令导入XML bean定义文件。

#### 1.2.3 使用容器
`ApplicationContext`是高级工厂的接口，能够维护不同bean及其依赖项的注册表。通过使用方法`T getBean（String name，Class <T> requiredType）`，您可以获取到bean的实例。

`ApplicationContext`允许您读取bean定义并访问它们，如以下示例所示：
```
// create and configure beans
ApplicationContext context = new ClassPathXmlApplicationContext("services.xml", "daos.xml");

// retrieve configured instance
PetStoreService service = context.getBean("petStore", PetStoreService.class);

// use configured instance
List<String> userList = service.getUsernameList();
```
使用Groovy配置，bootstrapping看起来非常相似。它有一个不同的上下文实现类，它是Groovy-aware（但也理解XML bean定义）。以下示例显示了Groovy配置：
```
ApplicationContext context = new GenericGroovyApplicationContext("services.groovy", "daos.groovy");
```

最灵活的变体是GenericApplicationContext与读者代表的组合--例如，使用XML文件的XmlBeanDefinitionReader，如以下示例所示：
```
GenericApplicationContext context = new GenericApplicationContext();
new XmlBeanDefinitionReader(context).loadBeanDefinitions("services.xml", "daos.xml");
context.refresh();
```
您还可以将GroovyBeanDefinitionReader用于Groovy文件，如以下示例所示：
```
GenericApplicationContext context = new GenericApplicationContext();
new GroovyBeanDefinitionReader(context).loadBeanDefinitions("services.groovy", "daos.groovy");
context.refresh();
```
你可以把不同reader委托给同一个`ApplicationContext`,从不同的配置源中读取bean定义

然后，您可以使用getBean来检索Bean的实例。 ApplicationContext接口有一些其他方法可以检索bean，但理想情况下，应用程序代码永远不应该使用它们。实际上，您的应用程序代码根本不应该调用getBean（）方法，因此根本不依赖于Spring API。
例如，Spring与Web框架的集成为各种Web框架组件（如控制器和JSF托管bean）提供依赖注入，允许您通过元数据（例如自动装配注释）声明对特定bean的依赖性。

### 1.3 Bean概览
一个Spring IoC容器管理一个或多个bean。这些bean是使用您提供给容器的配置元数据创建的（例如，以XML `<bean />`定义的形式）。

在容器内部，这些bean定义表示为`BeanDefinition`对象，其中包含（以及其他信息）以下元数据：

* 包限定的类名：通常，定义的bean的实际实现类。
* bean的行为，bean在容器中的行为方式（scope, lifecycle callbacks等等）
* 引用bean执行其工作所需的其他bean。这些引用也称为协作者或依赖项。（依赖信息）
* 要在新创建的对象中设置的其他配置设置--例如，池的大小限制或在管理连接池的Bean中使用的连接数。

此元数据转换为构成每个bean定义的一组属性。下表描述了这些属性：

Property|Explained in…​
--|:--
Class | [Instantiating Beans](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-class)
Name | [Naming Beans](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-beanname)
Scope | [Bean Scopes](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes)
Constructor arguments | [Dependency Injection](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)
Properties | [Dependency Injection](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)
Autowiring mode | [Autowiring Collaborators](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-autowire)
Lazy initialization mode | [Lazy-initialized Beans](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lazy-init)
Initialization method | [Initialization Callbacks](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-initializingbean)
Destruction method | [Destruction Callbacks](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-disposablebean)

除了包含有关如何创建特定bean的信息的bean定义之外，`ApplicationContext`实现还允许容器外部（由用户）创建的现有对象的注册。这是通过`getBeanFactory（）`方法访问`ApplicationContext`的BeanFactory来完成的，此方法会返回一个BeanFactory 
`DefaultListableBeanFactory`实现类。`DefaultListableBeanFactory`通过`registerSingleton（..）`和`registerBeanDefinition（..`）方法注册用户自己的类。但是，一般的应用程序仅使用通过常规bean定义元数据定义的bean。

> 需要尽早注册Bean元数据和手动提供的单例实例，以便容器在自动装配和其他内省步骤期间正确推理它们。虽然在某种程度上支持覆盖现有元数据和现有单例实例，
> 但是在运行时注册新bean（与对工厂的实时访问同时）并未得到官方支持，并且可能导致并发访问异常，bean容器中的状态不一致，或者都。

#### 1.3.1 bean的命名
每个bean都有一个或多个标识符。这些标识符在托管bean的容器中必须是唯一的。bean通常只有一个标识符。但是，如果它需要多个，则额的外标识符可以被视为别名。

在基于XML的配置元数据中，使用`id`属性，`name`属性或两者来指定bean标识符。`id`属性允许您精确的指定一个标识符。通常，这些名称是字母数字（'myBean'，'someService'等），但它们也可以包含特殊字符。如果要为bean引入别名，
还可以在`name`属性中指定它们，用逗号（`,`），分号（`;`）或空格分隔。在Spring 3.1之前的版本中，id属性被定义为`xsd:ID`类型，它约束了可能的字符。从3.1开始，它被定义为`xsd:string`类型。

为bean提供`name`或`id`不是必须的。如果未明确提供`name`或`id`，则容器会为该Bean生成唯一的名称。但是，如果要通过名称引用该bean，通过使用ref元素或Service Locator样式查找，则必须提供名称。不提供名称的原因与使用内
部bean和自动装配协作者有关。

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">bean命名约定</h3>
    <p>
        约定就是在命名bean时使用标准Java约定作为实例字段名称。也就是说，bean名称以小写字母开头，并从那里开始驼峰。比如accountManager，accountService，userDao，loginController等。
        统一bean命名规则使您的配置更易于阅读和理解。此外，如果您使用Spring AOP，那么在将建议应用于与名称相关的一组bean时，它会有很大帮助。
    </p>
</div>

> 通过类路径中的组件扫描(component scanning)，Spring按照前面描述的规则为未命名的组件生成bean名称。本质上，采用简单的类名并将其初始字符转换为小写。但是，在特殊情况下，当有多个字符且第一个和第二个字符都是大写字母时
> ，将使用原始的类名。这些规则与java.beans.Introspector.decapitalize（Spring在此处使用）中定义的规则相同。

<font size="5">在Bean Definition之外为bean设置别名</font>

在bean定义本身中，您可以为bean提供多个名称，方法是使用id属性指定的最多一个`id`和`name`属性中的任意数量的其他名称。这些名称可以是同一个bean的等效别名，对某些情况很有用，例如让应用程序中的每个组件通过使用特定于该组件本身的
bean名称来引用公共依赖项。

在bean定义中指定所有别名有时候无法满足需要，有时需要为其他地方定义的bean引入别名。在大型系统中通常就是这种情况，其中配置在每个子系统之间分配，每个子系统具有其自己的一组对象定义。在基于XML的配置元数据中，您可以使用
`<alias />`元素来完成此任务。以下示例显示了如何执行此操作：
```
<alias name="fromName" alias="toName"/>
```
fromName为原来bean的名字，toName为新的别名

例如，子系统A的配置元数据可以通过`subsystemA-dataSourc`e的名称来引用DataSource。子系统B的配置元数据可以通过`subsystemB-dataSource`的名称引用DataSource。在编写使用这两个子系统的主应用程序时，主应用程序通过
`myApp-dataSource`的名称引用DataSource。要使所有三个名称引用同一对象，可以将以下别名定义添加到配置元数据中:
```
<alias name="myApp-dataSource" alias="subsystemA-dataSource"/>
<alias name="myApp-dataSource" alias="subsystemB-dataSource"/>
```
现在，每个组件和主应用程序都可以通过一个唯一的名称引用dataSource，并保证不与任何其他定义冲突（有效地创建命名空间），但它们引用相同的bean。

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">Java-configuration</h3>
    <p>
        如果使用Javaconfiguration，则@Bean注释可用于提供别名。有关详细信息，请参阅使用@Bean批注。
    </p>
</div>

#### 1.3.2 实例化bean
bean definition本质上是用于创建一个或多个对象的配方。当需要bean definition创建实例时，容器会去会去查看这个bean的配方（也就是bean信息）。

如果使用基于XML的配置元数据，则指定要在`<bean />`元素的`class`属性中实例化的对象的类型（或类）。`class`属性（在内部，是`BeanDefinition`实例上的Class属性）通常是必需的。
（有关例外，请参阅使用[Instantiation by Using an Instance Factory Method](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-class-instance-factory-method)和[Bean Definition Inheritance](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-child-bean-definitions)。）您可以通过以下两种方式之一使用`Class`属性:

* 通常，在容器本身通过反射调用其构造函数直接创建bean的情况下指定要构造的bean类，稍微等同于使用new运算符的Java代码。
* 通过静态工厂方法实例化bean。在不太常见的情况下，容器在类上调用静态工厂方法来创建bean。从静态工厂方法的调用返回的对象类型可以完全是同一个类或另一个类。

<div style="background-color: #f7f7f8">
    <h6>Inner class names</h6>
    <p>
        如果要为静态内部类配置bean定义，则必须使用内部类的二进制名称。
        <p></p>
        例如，如果在com.example包中有一个名为SomeThing的类，并且此SomeThing类具有一个名为OtherThing的静态内部类，则bean定义上的class属性值将为com.example.SomeThing$OtherThing。
        <p></p>
        <strong>请注意，在名称中使用$字符可以将内部类名与外部类名分开。</strong>
    </p>
</div>

<font size="4">使用构造函数实例化</font>

当您通过构造方法创建bean时，所有普通类都可以使用并与Spring兼容。也就是说，正在开发的类不需要实现任何特定接口或以特定方式编码。简单地指定bean类就足够了。但是，根据您为该特定bean使用的IoC类型，您可能需要一个默认（空）构造函数。

Spring IoC容器几乎可以管理您希望它管理的任何类。它不仅限于管理真正的JavaBeans。大多数Spring用户更喜欢实际的JavaBeans，只有一个默认（无参数）构造函数，并且在容器中的属性之后建模了适当的setter和getter。您还可以在容器中拥有
更多外来的非bean样式类。例如，如果您需要使用绝对不符合JavaBean规范的旧连接池，那么Spring也可以对其进行管理。

使用基于XML的配置元数据，您可以按如下方式指定bean类：

```
<bean id="exampleBean" class="examples.ExampleBean"/>

<bean name="anotherExample" class="examples.ExampleBeanTwo"/>
```

有关为构造函数提供参数的机制（如果需要）以及在构造对象后设置对象实例属性的详细信息，请参阅 [Injecting Dependencies](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-collaborators)。


<font size="4">使用静态工厂实例化</font>

定义使用静态工厂方法创建的bean时，请使用`class`属性指定包含静态工厂方法的类和名为`factory-method`的属性，以指定工厂方法本身的名称。您应该能够调用此方法（使用可选参数，如稍后所述）并返回一个活动对象，随后将其视为通过构造函数
创建的对象。这种bean定义的一个用途是在遗留代码中调用静态工厂。

以下bean定义指定通过调用工厂方法来创建bean。该定义未指定返回对象的类型（类），仅指定包含工厂方法的类。在此示例中，createInstance（）方法必须是静态方法。以下示例显示如何指定工厂方法：
```
<bean id="clientService"
    class="examples.ClientService"
    factory-method="createInstance"/>
```
ClientService是一个静态工厂类，可以实例化类。

以下示例显示了一个可以使用前面的bean定义的类：
```
public class ClientService {
    private static ClientService clientService = new ClientService();
    private ClientService() {}

    public static ClientService createInstance() {
        return clientService;
    }
}
```

有关在从工厂返回对象后为工厂方法提供（可选）参数和设置对象实例属性的机制的详细信息，请参阅[Dependencies and Configuration in Detail](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-properties-detailed)。

<font size="4">使用实例工厂方法实例化</font>

与通过静态工厂方法实例化类似，使用实例工厂方法进行实例化会从容器调用现有bean的非静态方法来创建新bean。要使用此机制，请将`class`属性保留为空，并在`factory-bean`属性中指定当前（或父或祖先）容器中bean的名称，该容器包含要调用以创建
对象的实例方法。使用`factory-method`属性设置工厂方法本身的名称。以下示例显示如何配置此类bean：
```
<!-- the factory bean, which contains a method called createInstance() -->
<bean id="serviceLocator" class="examples.DefaultServiceLocator">
    <!-- inject any dependencies required by this locator bean -->
</bean>

<!-- the bean to be created via the factory bean -->
<bean id="clientService"
    factory-bean="serviceLocator"
    factory-method="createClientServiceInstance"/>
```

以下示例显示了相应的Java类：
```
public class DefaultServiceLocator {

    private static ClientService clientService = new ClientServiceImpl();

    public ClientService createClientServiceInstance() {
        return clientService;
    }
}
```

一个工厂类也可以包含多个工厂方法，如以下示例所示：
```
<bean id="serviceLocator" class="examples.DefaultServiceLocator">
    <!-- inject any dependencies required by this locator bean -->
</bean>

<bean id="clientService"
    factory-bean="serviceLocator"
    factory-method="createClientServiceInstance"/>

<bean id="accountService"
    factory-bean="serviceLocator"
    factory-method="createAccountServiceInstance"/>
```
以下示例显示了相应的Java类：
```
public class DefaultServiceLocator {

    private static ClientService clientService = new ClientServiceImpl();

    private static AccountService accountService = new AccountServiceImpl();

    public ClientService createClientServiceInstance() {
        return clientService;
    }

    public AccountService createAccountServiceInstance() {
        return accountService;
    }
}
```

这种方法表明工厂bean本身可以通过依赖注入（DI）进行管理和配置。请参阅[Dependencies and Configuration in Detail](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-properties-detailed)。

> **在Spring文档中，“factory bean”是指在Spring容器中配置并通过实例或静态工厂方法创建对象的bean。相比之下，FactoryBean（注意大小写）是指特定于Spring的FactoryBean,它是spring中的一个普通bean。**

### 1.4 依赖
典型的企业应用程序不包含单个对象（或Spring用法中的bean）。即使是最简单的应用程序也有一些对象可以协同工作，以呈现最终用户所看到的连贯应用程序。下一节将介绍如何定义多个独立的bean定义，以及对象协作实现目标的完全实现的应用程序。

#### 1.4.1 依赖注入
依赖注入（DI）是一个过程，通过这个过程，对象只能通过构造函数参数，工厂方法的参数或在构造方法或从工厂方法返回的对象实例上设置的属性来定义它们的依赖关系（即，它们使用的其他对象）。然后容器在创建bean时注入这些依赖项。
这个过程基本上是bean本身的反向（因此名称，控制反转），它通过使用类的直接构造或服务定位器模式来控制其依赖项的实例化或位置。

使用DI原则的代码更清晰，当对象提供其依赖项时，解耦更有效。该对象不查找其依赖项，也不知道依赖项的位置或类。因此，您的类变得更容易测试，特别是当依赖关系在接口或抽象基类上时，这允许在单元测试中使用存根或模拟实现。

DI存在两个主要变体：基于构造函数的依赖注入（Constructor-based dependency injection）和基于Setter的依赖注入（Setter-based dependency injection）。

##### 1.基于构造器注入（Constructor-based Dependency Injection）
基于构造函数的DI由容器调用具有多个参数的构造函数来完成，每个参数表示一个依赖项。调用具有特定参数的静态工厂方法来构造bean几乎是等效的，本讨论同样处理构造函数和静态工厂方法的参数。
以下示例显示了一个只能通过构造函数注入进行依赖注入的类：

```
public class SimpleMovieLister {

    // the SimpleMovieLister has a dependency on a MovieFinder
    private MovieFinder movieFinder;

    // a constructor so that the Spring container can inject a MovieFinder
    public SimpleMovieLister(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // business logic that actually uses the injected MovieFinder is omitted...
}
```

请注意，这个类没有什么特别之处。它是一个POJO，它不依赖于容器特定的接口，基类或注释。

##### 构造器参数解决方案（Constructor Argument Resolution）
通过使用参数的类型进行构造函数参数解析匹配。通过使用参数的类型进行构造函数参数解析匹配。如果bean定义的构造函数参数中不存在潜在的歧义，那么在bean定义中定义构造函数参数的顺序是在实例化bean时将这些参数提供给适当的构造函数的顺序。
考虑以下类：
```
package x.y;

public class ThingOne {

    public ThingOne(ThingTwo thingTwo, ThingThree thingThree) {
        // ...
    }
}
```
假设ThingTwo和ThingThree类与继承无关，则不存在潜在的歧义。因此，以下配置工作正常，您无需在`<constructor-arg />`元素中显式指定构造函数参数索引或类型。
```
<beans>
    <bean id="beanOne" class="x.y.ThingOne">
        <constructor-arg ref="beanTwo"/>
        <constructor-arg ref="beanThree"/>
    </bean>

    <bean id="beanTwo" class="x.y.ThingTwo"/>

    <bean id="beanThree" class="x.y.ThingThree"/>
</beans>
```
*构造器参数类型匹配（Constructor argument type matching）*

在前面的场景中，如果使用type属性显式指定构造函数参数的类型，则容器可以使用与简单类型匹配的类型。如下例所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <constructor-arg type="int" value="7500000"/>
    <constructor-arg type="java.lang.String" value="42"/>
</bean>
```

*构造器参数下标（Constructor argument index）*

您可以使用index属性显式指定构造函数参数的索引，如以下示例所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <constructor-arg index="0" value="7500000"/>
    <constructor-arg index="1" value="42"/>
</bean>
```
除了解决多个简单值的歧义之外，指定索引还可以解决构造函数具有相同类型的两个参数的歧义。

> 下标从0开始

*构造器参数名称（Constructor argument name）*

您还可以使用构造函数参数名称进行值消歧，如以下示例所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <constructor-arg name="years" value="7500000"/>
    <constructor-arg name="ultimateAnswer" value="42"/>
</bean>
```

请记住，为了使这项工作开箱即用，必须在启用调试标志的情况下编译代码，以便Spring可以从构造函数中查找参数名称。如果您不能或不想使用debug标志编译代码，则可以使用@ConstructorProperties JDK批注显式命名构造函数参数。

##### 2.基于set的注入（Setter-based Dependency Injection）
基于setter的DI是在调用无参数构造函数或无参数静态工厂方法来实例化bean之后，通过容器调用bean上的setter方法来完成的。

以下示例显示了一个只能通过使用纯setter注入进行依赖注入的类。这个类是传统的Java。它是一个POJO，它不依赖于容器特定的接口，基类或注释。

```
public class SimpleMovieLister {

    // the SimpleMovieLister has a dependency on the MovieFinder
    private MovieFinder movieFinder;

    // a setter method so that the Spring container can inject a MovieFinder
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // business logic that actually uses the injected MovieFinder is omitted...
}
```

`ApplicationContext`支持它管理的bean的基于构造函数和基于setter的DI。它还支持在通过构造函数方法注入了一些依赖项之后，然后再setter的DI。您可以以BeanDefinition的形式配置依赖项，您可以将它与PropertyEditor实例结合使用，
将属性从一种格式转换为另一种格式。但是，大多数Spring用户不直接使用这些类（即以编程方式），而是使用XML bean定义，带注释的组件（即使用@ Component，@ Controller等注释的类）或者@Bean方法。基于Java的@Configuration类。
然后，这些源在内部转换为BeanDefinition的实例，并用于加载整个Spring IoC容器实例。

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">Constructor-based or setter-based DI?</h3>
    <p>
        由于您可以混合基于构造函数和基于setter的DI，因此将构造函数用于强制依赖项，setter方法或配置方法用于可选依赖项的是一个很好的经验法则。请注意，在setter方法上使用@Required注释可用于使属性成为必需的依赖项;
        但是，最好使用编程验证参数的构造函数注入。
        <p></p>
        Spring团队通常提倡构造函数注入，因为它允许您将应用程序组件实现为不可变对象，并确保所需的依赖项不为null。此外，构造函数注入的组件始终以完全初始化的状态返回到客户端（调用）代码。
        作为旁注，大量的构造函数参数是一个bad code smell，暗示该类可能有太多的责任，应该重构以更好地解决关注点的正确分离。
        <p></p>
        Setter注入应主要仅用于可在类中指定合理默认值的可选依赖项。否则，必须在代码使用依赖项的任何位置执行非空检查。setter注入的一个好处是setter方法使该类的对象可以在以后重新配置或重新注入。
        因此，通过JMX MBean进行管理是二次注入的一个引人注目的用例。
        <p></p>
        使用对特定类最有意义的DI样式。有时，在处理您没有源的第三方类时会用到它。例如，如果第三方类没有公开任何setter方法，那么构造函数注入可能是唯一可用的DI形式。
    </p>
</div>

##### 依赖解决过程
容器执行bean依赖性解析，如下所示：

* `ApplicationContext`是使用描述所有bean的配置元数据创建和初始化的。配置元数据可以由XML，Java代码或注释指定。
* 对于每个bean，它的依赖关系以属性，构造函数参数或static-factory方法的参数的形式表示（如果使用它而不是普通的构造函数）。实际创建bean时，会将这些依赖项提供给bean。
* 每个属性或构造函数参数都是要设置的值的实际定义，或者是对容器中另一个bean的引用。
* 作为值的每个属性或构造函数参数都从其指定的格式转换为该属性或构造函数参数的实际类型。默认情况下，Spring可以将以字符串格式提供的值转换为所有内置类型，例如int，long，String，boolean等。

Spring容器在创建容器时验证每个bean的配置。但是，在实际创建bean之前，不会设置bean属性本身。创建容器时会创建单例作用域并设置为预实例化（默认值）的Bean。Scope在Bean scope中定义。否则，仅在请求时才创建bean。
创建bean可能会潜在的导致创建bean的图形，因为bean的依赖关系及依赖的依赖关系（依此类推）被创建和分配。请注意，这些依赖项之间的不匹配可能会延迟 - 也就是说，首次创建受影响的bean时。

```
The Spring container validates the configuration of each bean as the container is created. However, the bean properties themselves are not set until the bean is actually created. 
Beans that are singleton-scoped and set to be pre-instantiated (the default) are created when the container is created. Scopes are defined in Bean Scopes. Otherwise, the bean is
 created only when it is requested. Creation of a bean potentially causes a graph of beans to be created, as the bean’s dependencies and its dependencies' dependencies (and so on)
  are created and assigned. Note that resolution mismatches among those dependencies may show up late — that is, on first creation of the affected bean.
```

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">循环依赖（Circular dependencies）</h3>
    <p>
        如果您主要使用构造函数注入，则可以创建无法解析的循环依赖关系。
        <p></p>
        例如：类A通过构造函数注入需要类B的实例，而类B通过构造函数注入需要类A的实例。如果为A类和B类配置bean相互注入，则Spring IoC容器会在运行时检测此循环引用，并抛出BeanCurrentlyInCreationException。
        <p></p>
        一种可能的解决方案是编辑由setter而不是构造函数配置的某些类的源代码。或者，避免构造函数注入并仅使用setter注入。换句话说，尽管不推荐使用，但您可以使用setter注入配置循环依赖项。
        <p></p>
        与典型情况（没有循环依赖）不同，bean A和bean B之间的循环依赖强制其中一个bean在完全初始化之前被注入另一个bean（一个经典的鸡与鸡蛋场景）。比如A被强制注入到B，但是A在B之后完全实例化。
    </p>
</div>

一般情况下你可以相信Spring在做正确的事。它在容器加载时检测配置问题，例如对不存在的bean的引用和循环依赖。当实际创建bean时，
Spring会尽可能晚地设置属性并解析依赖关系。这意味着当您请求对象时，如果在创建该对象或其依赖项之一时出现问题，Spring容器（已正确加载）可以延迟生成异常--例如，bean因缺少属性或无效属性而抛出异常。
这可能会延迟一些配置问题的可见性，这就是默认情况下`ApplicationContext`实现预先实例化单例bean的原因。以实际需要之前创建这些bean的一些前期时间和内存为代价，您在创建ApplicationContext时发现配置问题，而不会延迟。
但是仍然可以覆盖此默认行为，以便单例bean可以懒惰地初始化，而不是预先实例化（前提是你的配置是没有错误）。

如果不存在循环依赖问题，当一个或多个协作bean被注入依赖bean时，每个协作bean在被注入依赖bean之前完全配置。
这意味着，如果bean A依赖于bean B，则Spring IoC容器在调用bean A上的setter方法之前完全配置bean B。
换句话说，先实例化bean（如果它不是预先实例化的单例），然后设置其依赖项，最后调用相关的生命周期方法（例如配置的[init](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-initializingbean)方法或[InitializingBean](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle-initializingbean)回调方法）。

##### 依赖注入的示例
以下示例将基于XML的配置元数据用于基于setter的DI。 Spring XML配置文件的一小部分指定了一些bean定义，如下所示：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <!-- setter injection using the nested ref element -->
    <property name="beanOne">
        <ref bean="anotherExampleBean"/>
    </property>

    <!-- setter injection using the neater ref attribute -->
    <property name="beanTwo" ref="yetAnotherBean"/>
    <property name="integerProperty" value="1"/>
</bean>

<bean id="anotherExampleBean" class="examples.AnotherBean"/>
<bean id="yetAnotherBean" class="examples.YetAnotherBean"/>
```
以下示例显示了相应的ExampleBean类：
```
public class ExampleBean {

    private AnotherBean beanOne;

    private YetAnotherBean beanTwo;

    private int i;

    public void setBeanOne(AnotherBean beanOne) {
        this.beanOne = beanOne;
    }

    public void setBeanTwo(YetAnotherBean beanTwo) {
        this.beanTwo = beanTwo;
    }

    public void setIntegerProperty(int i) {
        this.i = i;
    }
}
```

在前面的示例中，声明setter与XML文件中指定的属性匹配。以下示例使用基于构造函数的DI：
```
<bean id="exampleBean" class="examples.ExampleBean">
    <!-- constructor injection using the nested ref element -->
    <constructor-arg>
        <ref bean="anotherExampleBean"/>
    </constructor-arg>

    <!-- constructor injection using the neater ref attribute -->
    <constructor-arg ref="yetAnotherBean"/>

    <constructor-arg type="int" value="1"/>
</bean>

<bean id="anotherExampleBean" class="examples.AnotherBean"/>
<bean id="yetAnotherBean" class="examples.YetAnotherBean"/>
```
以下示例显示了相应的ExampleBean类：
```
public class ExampleBean {

    private AnotherBean beanOne;

    private YetAnotherBean beanTwo;

    private int i;

    public ExampleBean(
        AnotherBean anotherBean, YetAnotherBean yetAnotherBean, int i) {
        this.beanOne = anotherBean;
        this.beanTwo = yetAnotherBean;
        this.i = i;
    }
}
```
bean定义中指定的构造函数参数用作ExampleBean的构造函数的参数。

现在考虑这个例子的变体，其中，不是使用构造函数，而是告诉Spring调用静态工厂方法来返回对象的实例：
```
<bean id="exampleBean" class="examples.ExampleBean" factory-method="createInstance">
    <constructor-arg ref="anotherExampleBean"/>
    <constructor-arg ref="yetAnotherBean"/>
    <constructor-arg value="1"/>
</bean>

<bean id="anotherExampleBean" class="examples.AnotherBean"/>
<bean id="yetAnotherBean" class="examples.YetAnotherBean"/>
```
以下示例显示了相应的ExampleBean类：
```
public class ExampleBean {

    // a private constructor
    private ExampleBean(...) {
        ...
    }

    // a static factory method; the arguments to this method can be
    // considered the dependencies of the bean that is returned,
    // regardless of how those arguments are actually used.
    public static ExampleBean createInstance (
        AnotherBean anotherBean, YetAnotherBean yetAnotherBean, int i) {

        ExampleBean eb = new ExampleBean (...);
        // some other operations...
        return eb;
    }
}
```
静态工厂方法的参数由<constructor-arg />元素提供，与构造函数完全相同。工厂方法返回的类的类型不必与静态工厂类相同（尽管在本例中，它是一样的）。
实例（非静态）工厂方法可以以基本相同的方式使用（除了使用factory-bean属性而不是class属性），因此我们不在这里讨论这些细节。

#### 1.4.2 依赖关系和配置的细节
如上一节所述，您可以将bean属性和构造函数参数定义为对其他托管bean（协作者）的引用，也可以将其定义为内联定义的值。为此，Spring的基于XML的配置元数据支持其`<property />`和`<constructor-arg />`元素中的子元素类型。

##### 直值（基元，字符串等）(Straight Values (Primitives, Strings, and so on))
`<property />`元素的`value`属性将属性或构造函数参数指定为人类可读的字符串表示形式。Spring的转换服务（[conversion service](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#core-convert-ConversionService-API)）
用于将这些值从String转换为属性或参数的实际类型。以下示例显示了要设置的各种值：
```
<bean id="myDataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close">
    <!-- results in a setDriverClassName(String) call -->
    <property name="driverClassName" value="com.mysql.jdbc.Driver"/>
    <property name="url" value="jdbc:mysql://localhost:3306/mydb"/>
    <property name="username" value="root"/>
    <property name="password" value="masterkaoli"/>
</bean>
```
以下示例使用p命名空间进行更简洁的XML配置:
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:p="http://www.springframework.org/schema/p"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
    https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="myDataSource" class="org.apache.commons.dbcp.BasicDataSource"
        destroy-method="close"
        p:driverClassName="com.mysql.jdbc.Driver"
        p:url="jdbc:mysql://localhost:3306/mydb"
        p:username="root"
        p:password="masterkaoli"/>

</beans>
```
前面的XML更简洁。但是，除非您在创建bean定义时使用支持自动属性完成的IDE（例如IntelliJ IDEA或Spring Tool Suite），否则会在运行时而不是设计时发现拼写错误。强烈建议使用此类IDE帮助。

您还可以配置`java.util.Properties`实例，如下所示：
```
<bean id="mappings"
    class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">

    <!-- typed as a java.util.Properties -->
    <property name="properties">
        <value>
            jdbc.driver.className=com.mysql.jdbc.Driver
            jdbc.url=jdbc:mysql://localhost:3306/mydb
        </value>
    </property>
</bean>
```
Spring容器通过使用JavaBeans `PropertyEditor`机制将`<value />`元素内的文本转换为`java.util.Properties`实例。
这是一个很好的快捷方式，并且是Spring团队支持在值属性样式上使用嵌套`<value />`元素的一些地方之一。

##### The idref element
`idref`元素只是一种防错方法，可以将容器中另一个bean的id（字符串值 - 而不是引用）传递给`<constructor-arg />`或`<property />`元素。以下示例显示了如何使用它：
```
<bean id="theTargetBean" class="..."/>

<bean id="theClientBean" class="...">
    <property name="targetName">
        <idref bean="theTargetBean"/>
    </property>
</bean>
```
前面的bean定义代码段与以下代码段完全等效（在运行时）：
```
<bean id="theTargetBean" class="..." />

<bean id="client" class="...">
    <property name="targetName" value="theTargetBean"/>
</bean>
```
第一种形式优于第二种形式，因为使用`idref`标记允许容器在部署时验证引用的命名bean实际存在(部属时就校验`targetName`是否存在)。在第二个变体中，不对传递给`client`bean的`targetName`属性的值执行验证。当客户端bean实际被实例化时，
才会发现错别字（最有可能致命的结果）。如果`client`bean是 prototype bean，则只能在部署容器后很长时间才能发现此错误和产生的异常。

> 4.0 beans XSD中不再支持idref元素的local属性，因为它不再提供常规bean引用的值。升级到4.0架构时，将现有的idref local引用更改为idref bean。

`<idref />`元素带来值的常见位置（至少在Spring 2.0之前的版本中）是在`ProxyFactoryBean` bean定义中的AOP拦截器的配置中。指定拦截器名称时使用`<idref />`元素可以防止拼写错误的拦截器ID。

##### 参考其他bean（合作者（被注入的依赖bean））
ref元素是`<constructor-arg />`或`<property />`定义元素中的最后一个元素。在这里，您将bean的指定属性的值设置为对容器管理的另一个bean（协作者）的引用。
被注入的依赖bea在设置该属性之前根据需要按需初始化它。（如果被注入依赖是单例的，则他可能已由容器初始化）。所有引用最终都是对另一个对象的引用。
范围和验证取决于您是通过`bean`，`local`或`parent`属性指定其他对象的ID还是名称。

通过`<ref />`标记的`bean`属性指定目标bean是最常用的形式，并允许创建对同一容器或父容器中的任何bean的引用，而不管它是否在同一XML文件中。
bean属性的值可以与目标bean的id属性相同，也可以与目标bean的name属性中的值之一相同。以下示例显示如何使用ref元素：
```
<ref bean="someBean"/>
```
通过`parent`属性指定目标bean会创建对当前容器的父容器中的`bean`的引用。`parent`属性的值可以与目标bean的`id`属性或目标bean的`name`属性中的值之一相同。
目标bean必须位于当前bean的父容器中。您应该使用此bean引用变体，主要是在您具有容器层次结构并且希望将现有bean包装在父容器中，并使用与父bean具有相同名称的代理。
以下一对列表显示了如何使用父属性：
```
<!-- in the parent context -->
<bean id="accountService" class="com.something.SimpleAccountService">
    <!-- insert dependencies as required as here -->
</bean>
```
```
<!-- in the child (descendant) context -->
<bean id="accountService" <!-- bean name is the same as the parent bean -->
    class="org.springframework.aop.framework.ProxyFactoryBean">
    <property name="target">
        <ref parent="accountService"/> <!-- notice how we refer to the parent bean -->
    </property>
    <!-- insert other configuration and dependencies as required here -->
</bean>
```

##### Inner Beans (内部类)
`<property />`或`<constructor-arg />`元素中的`<bean />`元素定义了内部bean，如下例所示：
```
<bean id="outer" class="...">
    <!-- instead of using a reference to a target bean, simply define the target bean inline -->
    <property name="target">
        <bean class="com.example.Person"> <!-- this is the inner bean -->
            <property name="name" value="Fiona Apple"/>
            <property name="age" value="25"/>
        </bean>
    </property>
</bean>
```
内部bean定义不需要定义的ID或名称。如果指定，则容器不使用此类值作为标识符。容器还会在创建时忽略scope标志，因为内部bean始终是匿名的，并且始终使用外部bean创建。
不可能独立访问内部bean或将它们注入协作bean而不是封闭bean。

作为一个极端情况，可以从自定义范围接收销毁回调 - 例如，对于包含在单例bean中的请求范围内部bean。

##### 集合
`<list />`，`<set />`，`<map />`和`<props />`元素分别设置Java Collection类型List，Set，Map和Properties的属性和参数。以下示例显示了如何使用它们：
```
<bean id="moreComplexObject" class="example.ComplexObject">
    <!-- results in a setAdminEmails(java.util.Properties) call -->
    <property name="adminEmails">
        <props>
            <prop key="administrator">administrator@example.org</prop>
            <prop key="support">support@example.org</prop>
            <prop key="development">development@example.org</prop>
        </props>
    </property>
    <!-- results in a setSomeList(java.util.List) call -->
    <property name="someList">
        <list>
            <value>a list element followed by a reference</value>
            <ref bean="myDataSource" />
        </list>
    </property>
    <!-- results in a setSomeMap(java.util.Map) call -->
    <property name="someMap">
        <map>
            <entry key="an entry" value="just some string"/>
            <entry key ="a ref" value-ref="myDataSource"/>
        </map>
    </property>
    <!-- results in a setSomeSet(java.util.Set) call -->
    <property name="someSet">
        <set>
            <value>just some string</value>
            <ref bean="myDataSource" />
        </set>
    </property>
</bean>
```
map的键或值的值或set的值也可以是以下任何元素：

    bean | ref | idref | list | set | map | props | value | null

##### 集合合并
Spring容器还支持合并集合。应用程序开发人员可以定义父`<list />`，`<map />`，`<set />`或`<props />`元素，并具有子`<list />`，`<map />`，`<set />`或`<props />`元素继承和覆盖父集合中的值。
也就是说，子集合的值是合并父集合和子集合的元素的结果，子集合的元素覆盖父集合中指定的值。

关于合并的这一部分讨论了父子bean机制。不熟悉父母和子bean定义的读者可以在先阅读[相关部分](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-child-bean-definitions)。

以下示例演示了集合合并：
```
<beans>
    <bean id="parent" abstract="true" class="example.ComplexObject">
        <property name="adminEmails">
            <props>
                <prop key="administrator">administrator@example.com</prop>
                <prop key="support">support@example.com</prop>
            </props>
        </property>
    </bean>
    <bean id="child" parent="parent">
        <property name="adminEmails">
            <!-- the merge is specified on the child collection definition -->
            <props merge="true">
                <prop key="sales">sales@example.com</prop>
                <prop key="support">support@example.co.uk</prop>
            </props>
        </property>
    </bean>
<beans>
```

请注意在子bean定义的`adminEmails`属性的`<props />`元素上使用`merge = true`属性。chlid bean 将包含parent和child中的所有属性，即
```
administrator=administrator@example.com
sales=sales@example.com
support=support@example.co.uk
```

子属性集合的值集继承父`<props />`中的所有属性元素，子值的支持值将覆盖父集合中的值。

此合并行为同样适用于`<list />`，`<map />`和`<set />`集合类型。在使用`<list />`元素时，会有集合排序问题，与定义时的顺序一致（即，有序的值集合的概念）。父级的值位于所有子级列表的值之前。
对于Map，Set和Properties集合类型，不存在排序。因此，对于作为容器在内部使用的关联Map，Set和Properties实现类型的基础的集合类型，没有排序问题。

##### 强类型集合（Strongly-typed collection）
通过在Java 5中引入泛型类型，您可以使用强类型集合。也就是说，可以声明Collection类型，使其只能包含（例如）String元素。
如果你使用Spring依赖注入一个强类型的Collection到bean中，您可以利用Spring的类型转换支持，以便强类型Collection实例的元素在添加到Collection之前转换为适当的类型。
以下Java类和bean定义显示了如何执行此操作：
```
public class SomeClass {

    private Map<String, Float> accounts;

    public void setAccounts(Map<String, Float> accounts) {
        this.accounts = accounts;
    }
}

<beans>
    <bean id="something" class="x.y.SomeClass">
        <property name="accounts">
            <map>
                <entry key="one" value="9.99"/>
                <entry key="two" value="2.75"/>
                <entry key="six" value="3.99"/>
            </map>
        </property>
    </bean>
</beans>
```

##### NULL值和空字符串值
Spring将属性等的空参数视为空字符串。以下基于XML的配置元数据片段将`email`属性设置为空String值（“”）。
```
<bean class="ExampleBean">
    <property name="email" value=""/>
</bean>
```
上面的示例等效于以下Java代码：
```
exampleBean.setEmail("");
```

`<null />`元素处理NULL值。以下清单显示了一个示例：
```
<bean class="ExampleBean">
    <property name="email">
        <null/>
    </property>
</bean>
```
上述配置等同于以下Java代码：
```
exampleBean.setEmail(null);
```

##### 带有p命名空间的XML快捷方式
p-namespace允许您使用bean元素的属性（而不是嵌套的`<property />`元素）来描述属性值协作bean，或两者。
Spring支持具有命名空间的可扩展配置格式，这些命名空间基于XML Schema定义。本章中讨论的bean配置格式在XML Schema文档中定义。但是，p-namespace未在XSD文件中定义，仅存在于Spring的核心中。

以下示例显示了两个XML片段（第一个使用标准XML格式，第二个使用p命名空间）解析为相同的结果：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:p="http://www.springframework.org/schema/p"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean name="classic" class="com.example.ExampleBean">
        <property name="email" value="someone@somewhere.com"/>
    </bean>

    <bean name="p-namespace" class="com.example.ExampleBean"
        p:email="someone@somewhere.com"/>
</beans>
```
该示例显示了bean定义中名为email的p命名空间中的属性。这告诉Spring包含一个属性声明。如前所述，p命名空间没有schema定义，因此您可以将属性的名称设置为属性名称。

下一个示例包括另外两个bean定义，它们都引用了另一个bean：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:p="http://www.springframework.org/schema/p"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean name="john-classic" class="com.example.Person">
        <property name="name" value="John Doe"/>
        <property name="spouse" ref="jane"/>
    </bean>

    <bean name="john-modern"
        class="com.example.Person"
        p:name="John Doe"
        p:spouse-ref="jane"/>

    <bean name="jane" class="com.example.Person">
        <property name="name" value="Jane Doe"/>
    </bean>
</beans>
```
此示例不仅包含使用p命名空间的属性值，还使用特殊格式来声明属性引用。
第一个bean定义使用<property name =“spouse”ref =“jane”/>来创建从bean john到bean jane的引用，而第二个bean定义使用p：spouse-ref =“jane”作为要执行的属性完全相同的事情。
在这个案例中，`spouse`是属性名称，而-ref部分表示这不是直接值，而是对另一个bean的引用。

> p命名空间不如标准XML格式灵活。例如，声明属性引用的格式与以Ref结尾的属性冲突，而标准XML格式则不然。我们建议您仔细选择您的方法并将其传达给您的团队成员，以避免生成同时使用所有三种方法的XML文档。

##### 带有c命名空间的XML快捷方式 （构造方法）
与带有p-namespace的XML Shortcut类似，Spring 3.1中引入的c-namespace允许使用内联属性来配置构造函数参数，而不是嵌套的constructor-arg元素。

以下示例使用c：namespace来执行与基于构造函数的依赖注入相同的操作：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:c="http://www.springframework.org/schema/c"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="beanTwo" class="x.y.ThingTwo"/>
    <bean id="beanThree" class="x.y.ThingThree"/>

    <!-- traditional declaration with optional argument names -->
    <bean id="beanOne" class="x.y.ThingOne">
        <constructor-arg name="thingTwo" ref="beanTwo"/>
        <constructor-arg name="thingThree" ref="beanThree"/>
        <constructor-arg name="email" value="something@somewhere.com"/>
    </bean>

    <!-- c-namespace declaration with argument names -->
    <bean id="beanOne" class="x.y.ThingOne" c:thingTwo-ref="beanTwo"
        c:thingThree-ref="beanThree" c:email="something@somewhere.com"/>

</beans>
```
`c:`名称空间使用与`p:`one（bean引用的尾随-ref）相同的约定，用于按名称设置构造函数参数。类似地，它需要在XML文件中声明，即使它没有在XSD模式中定义（它存在于Spring核心内部）。

对于构造函数参数名称不可用的罕见情况（通常在没有调试信息的情况下编译字节码），您可以使用回退到参数索引，如下所示：
```
<!-- c-namespace index declaration -->
<bean id="beanOne" class="x.y.ThingOne" c:_0-ref="beanTwo" c:_1-ref="beanThree"
    c:_2="something@somewhere.com"/>
```
> 由于XML语法，索引表示法要求存在前导_，因为XML属性名称不能以数字开头（即使某些IDE允许）。对于`<constructor-arg>`元素也可以使用相应的索引表示法，但不常用，因为声明的简单顺序通常就足够了。

实际上，构造函数解析机制在匹配参数方面非常有效，因此除非您确实需要，否则我们建议在整个配置中使用名称表示法而不是索引。

##### 复合属性名称 （Compound Property Names）
只要除最终属性名称之外的路径的所有组件都不为null，您可以在设置bean属性时使用复合或嵌套属性名称。考虑以下bean定义：
```
<bean id="something" class="things.ThingOne">
    <property name="fred.bob.sammy" value="123" />
</bean>
```
这个bean有一个`fred`属性，它有一个`bob`属性，它有一个`sammy`属性，最终的`sammy`属性被设置为`123`。
为了使它能够工作，在构造bean之后，`something`的`fred`属性和`fred`的`bob`属性不能为null。否则，抛出NullPointerException。

##### 使用`depends-on`
如果bean是另一个bean的依赖项，那通常意味着将一个bean设置为另一个bean的属性。通常，您可以使用基于XML的配置元数据中的`<ref />`元素来完成此操作。但是，有时bean之间的依赖关系不那么直接。
例如，需要触发类中的静态初始化程序，例如数据库驱动程序注册。depends-on属性可以显式强制初始化一个或多个bean，在初始化使用此元素的bean之前。
以下示例使用depends-on属性表示对单个bean的依赖关系：
```
<bean id="beanOne" class="ExampleBean" depends-on="manager"/>
<bean id="manager" class="ManagerBean" />
```
要表示对多个bean的依赖关系，请提供bean名称列表作为depends-on属性的值（逗号，空格和分号是有效的分隔符）：
```
<bean id="beanOne" class="ExampleBean" depends-on="manager,accountDao">
    <property name="manager" ref="manager" />
</bean>

<bean id="manager" class="ManagerBean" />
<bean id="accountDao" class="x.y.jdbc.JdbcAccountDao" />
```
> `depends-on`属性既可以指定初始化时间依赖性，也可以指定单独的bean，相应的销毁时间依赖性。在给定的bean本身被销毁之前，首先销毁定义与给定bean的依赖关系的从属bean。因此，依赖也可以控制关​​闭顺序。

##### 延迟加载
默认情况下，`ApplicationContext`实现会急切地创建和配置所有单例bean，作为初始化过程的一部分。通常，这种预先实例化是可取的，因为配置或周围环境中的错误是立即发现的，而不是几小时甚至几天后。
当不希望出现这种情况时，可以通过将bean定义标记为延迟初始化来阻止单例bean的预实例化。延迟初始化的bean告诉IoC容器在第一次请求时创建bean实例，而不是在启动时。

在XML中，此行为由`<bean />`元素上的`lazy-init`属性控制，如以下示例所示：
```
<bean id="lazy" class="com.something.ExpensiveToCreateBean" lazy-init="true"/>
<bean name="not.lazy" class="com.something.AnotherBean"/>
```
当`ApplicationContext`使用前面的配置时，在`ApplicationContext`启动时不会急切地预先实例化lazy bean，而是急切地预先实例化not.lazy bean。
但是，当延迟初始化的bean是未延迟初始化的单例bean的依赖项时，ApplicationContext会在启动时创建延迟初始化的bean，因为它必须满足单例的依赖关系。惰性初始化的bean被注入到其他地方的单独的bean中，而这个bean并不是惰性初始化的。

您还可以使用`<beans />`元素上的`default-lazy-init`属性在容器级别控制延迟初始化，以下示例显示：
```
<beans default-lazy-init="true">
    <!-- no beans will be pre-instantiated... -->
</beans>
```

#### 1.4.5 自动装配依赖(Autowiring Collaborators)
Spring容器可以自动连接协作bean之间的关系。您可以通过检查ApplicationContext的内容让Spring自动为您的bean解析协作者（其他bean）。自动装配具有以下优点：

* 自动装配可以显着减少对指定属性或构造函数参数的需要。（[在本章其他地方](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-child-bean-definitions)讨论的其他机制，如bean模板，在这方面也很有价值。）
* 自动装配可以随着对象的发展更新配置。例如，如果需要向类添加依赖项，则可以自动满足该依赖项，而无需修改配置。因此，自动装配在开发期间尤其有用，而不会在代码库变得更稳定时否定切换到显式布线的选项。

使用基于XML的配置元数据（请参阅依赖注入）时，可以使用<bean />元素的autowire属性为bean定义指定autowire模式。自动装配功能有四种模式。您指定每个bean的自动装配，因此可以选择要为哪些bean进行自动装配。下表描述了四种自动装配模式：

Mode|Explanation
--|:--
no|（默认）无自动装配。Bean引用必须由ref元素定义。不建议对较大的部署更改默认设置，因为明确指定协作者可以提供更好的控制和清晰度。在某种程度上，它记录了系统的结构。（任然可以使用`@Autowried`注解自动装配）
byName|按属性名称自动装配。 Spring查找与需要自动装配的属性同名的bean。例如，如果bean定义按名称设置为autowire并且它包含master属性（即，它具有setMaster（..）方法），则Spring会查找名为master的bean定义并使用它来设置属性。
byType|如果容器中只存在一个属性类型的bean，则允许属性自动装配。如果存在多个，则抛出致命异常，这表示您不能对该bean使用byType自动装配。如果没有匹配的bean，则不会发生任何事情（该属性未设置）。
constructor|类似于byType但适用于构造函数参数。如果容器中没有构造函数参数类型的一个bean，则会引发致命错误。

使用byType或构造函数自动装配模式，您可以连接数组和类型集合。在这种情况下，提供容器内与预期类型匹配的所有autowire候选者以满足依赖性。如果预期的键类型是String，则可以自动装配强类型的Map实例。
自动装配的Map实例的值由与预期类型匹配的所有Bean实例组成，Map实例的键包含相应的bean名称。

##### 自动装配的局限和缺点
当在整个项目中一致地使用自动装配时，自动装配效果最佳。如果一般不使用自动装配，那么开发人员使用它来连接一个或两个bean定义可能会让人感到困惑。
考虑自动装配的局限和缺点：

* property和constructor-arg设置中的显式依赖项始终覆盖自动装配。您不能自动装配简单属性，例如基元(基本类型)，字符串和类（以及此类简单属性的数组）。这种限制是按设计的。
* 自动装配不如显式ref精确。虽然如前面的表中所述，但Spring会谨慎地避免在可能产生意外结果的模糊性的情况下进行猜测。您不再明确记录Spring管理对象之间的关系。
* 可能无法为可能从Spring容器生成文档的工具提供接线信息。
* 容器中的多个bean定义可以匹配setter方法或构造函数参数指定的类型以进行自动装配。对于数组，集合或Map实例，这不一定是个问题。但是，对于期望单个值的依赖关系，这种模糊性不是任意解决的。如果没有可用的唯一bean定义，则抛出异常。

在后一种情况下，您有几种选择：

* 放弃自动装配，使用显示装配。
* 通过将autowire-candidate属性设置为false，避免对bean定义进行自动装配，如[下一节](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-autowire-candidate)所述。
* 通过将其`<bean />`元素的`primary`属性设置为`true`，将single bean定义指定为主要候选者。
* 实现基于注释的配置可用的更细粒度的控件，如[基于注释](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-annotation-config)的容器配置中所述。

###### 从自动装配中排除Bean
在每个bean的基础上，您可以从自动装配中排除bean。在Spring的XML格式中，将`<bean />`元素的`autowire-candidate`属性设置为false。容器使特定的bean定义对自动装配基础结构不可用（包括注释样式配置，如`@Autowired`）。

> autowire-candidate属性仅影响基于类型的自动装配。它不会影响名称的显式引用，即使指定的bean的autowire candidate=false，也会解析它。因此，如果名称匹配，则按名称自动装配会注入bean。
> 也就时说，如果是按name匹配，则会忽略autowire-candidate属性

您还可以根据与bean名称的模式匹配来限制autowire候选者。顶级`<beans />`元素在其`default-autowire-candidates`属性中接受一个或多个模式。例如，要将autowire候选状态限制为名称以Repository结尾的任何bean，请提供值`*Repository`。
多个用逗号隔开。bean定义的`autowire-candidate`属性的显式值`true`或`false`始终优先。对于此类bean，模式匹配规则不适用。也就是说只有`default-autowire-candidates`匹配的才能成为自动装配，但`autowire-candidate`的优先级要比
`default-autowire-candidates`高。

这些技术对于您永远不希望通过自动装配注入其他bean的bean非常有用。这并不意味着排除的bean本身不能使用自动装配进行配置。相反，bean本身不是自动装配其他bean的候选者。**也就是说，非候选者的bean，他自己还是可以使用自动装配。**

#### 1.4.6 方法注入

在大多数应用程序场景中，容器中的大多数bean都是单例。当单例bean需要与另一个单例bean协作或非单例bean需要与另一个非单例bean协作时，通常通过将一个bean定义为另一个bean的属性来处理依赖关系。
当bean生命周期不同时会出现问题。假设单例bean A需要使用非单例（prototype）bean B，可能是在A上的每个方法调用上。容器只创建一次单独的bean A，因此只有一次机会来设置属性。
每次需要时，容器都不能为bean A提供bean B的新实例。

一个解决方案是放弃一些控制反转。您可以通过实现ApplicationContextAware接口使bean A了解容器，并通过对容器进行getBean（“B”）调用，每次bean A需要时都要求（通常是新的）bean B实例。以下示例显示了此方法：
```
// a class that uses a stateful Command-style class to perform some processing
package fiona.apple;

// Spring-API imports
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class CommandManager implements ApplicationContextAware {

    private ApplicationContext applicationContext;

    public Object process(Map commandState) {
        // grab a new instance of the appropriate Command
        Command command = createCommand();
        // set the state on the (hopefully brand new) Command instance
        command.setState(commandState);
        return command.execute();
    }

    protected Command createCommand() {
        // notice the Spring API dependency!
        return this.applicationContext.getBean("command", Command.class);
    }

    public void setApplicationContext(
            ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}
```
前面的内容是不可取的，因为业务代码知道并耦合到Spring Framework。方法注入是Spring IoC容器的一个高级功能，可以让您干净地处理这个用例。

    您可以在此[博客](https://spring.io/blog/2004/08/06/method-injection/)条目中阅读有关Method Injection的动机的更多信息。

##### 查找方法注入
查找方法注入是容器覆盖容器管理的bean上的方法并返回容器中另一个命名bean的查找结果的能力。查找通常涉及prototype bean，如上一节中描述的场景。
Spring Framework通过使用CGLIB库中的字节码生成来动态生成覆盖该方法的子类来实现此方法注入。

> * 为了使这个动态子类工作，Spring bean容器子类不能是final的类，要覆盖的方法也不能是final。
> * 对具有抽象方法的类进行单元测试需要您自己对类进行子类化，并提供抽象方法的存根实现。
> * 组件扫描也需要具体的方法，这需要具体的类来获取。
> * 另一个关键限制是查找方法不适用于工厂方法，特别是配置类中的@Bean方法。在这种情况下，容器不负责创建实例，因此无法动态创建运行时生成的子类。

对于前面代码片段中的CommandManager类，Spring容器动态地覆盖createCommand（）方法的实现。CommandManager类没有任何Spring依赖项，因为重写的示例显示：
```
package fiona.apple;

// no more Spring imports!

public abstract class CommandManager {

    public Object process(Object commandState) {
        // grab a new instance of the appropriate Command interface
        Command command = createCommand();
        // set the state on the (hopefully brand new) Command instance
        command.setState(commandState);
        return command.execute();
    }

    // okay... but where is the implementation of this method?
    protected abstract Command createCommand();
}
```
在包含要注入的方法的客户机类（在本例中为CommandManager）中，要注入的方法需要以下形式的签名：

    <public|protected> [abstract] <return-type> theMethodName(no-arguments);

如果方法是抽象的，则动态生成的子类实现该方法。否则，动态生成的子类将覆盖原始类中定义的具体方法。请考虑以下示例：
```
<!-- a stateful bean deployed as a prototype (non-singleton) -->
<bean id="myCommand" class="fiona.apple.AsyncCommand" scope="prototype">
    <!-- inject dependencies here as required -->
</bean>

<!-- commandProcessor uses statefulCommandHelper -->
<bean id="commandManager" class="fiona.apple.CommandManager">
    <lookup-method name="createCommand" bean="myCommand"/>
</bean>
```
标识为`commandManager`的bean在需要`myCommand` bean的新实例时调用自己的`createCommand()`方法。如果实际需要，您必须小心将`myCommand` bean部署为原型。如果它是单例，则每次都返回myCommand bean的相同实例。

或者，在基于注释的组件模型中，您可以通过@Lookup注释声明查找方法，如以下示例所示：
```
public abstract class CommandManager {

    public Object process(Object commandState) {
        Command command = createCommand();
        command.setState(commandState);
        return command.execute();
    }

    @Lookup("myCommand")
    protected abstract Command createCommand();
}
```
或者，更普遍的用法，您可以依赖于针对查找方法的声明返回类型解析目标bean：
```
public abstract class CommandManager {

    public Object process(Object commandState) {
        MyCommand command = createCommand();
        command.setState(commandState);
        return command.execute();
    }

    @Lookup
    protected abstract MyCommand createCommand();
}
```

请注意，您通常应该使用具体的存根实现来声明这种带注释的查找方法，为了使它们与Spring的组件扫描规则兼容，默认情况下抽象类被忽略。此限制不适用于显式注册或显式导入的bean类。

> 访问不同范围的目标bean的另一种方法是ObjectFactory / Provider注入点。[请参阅Scoped Beans作为依赖关系](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-other-injection）。
> 您可能还会发现ServiceLocatorFactoryBean（在org.springframework.beans.factory.config包中）很有用。

##### 任意方法替换
与查找方法注入相比，一种不太有用的方法注入形式是使用另一个方法实现替换托管bean中的任意方法。您可以安全地跳过本节的其余部分，直到您确实需要此功能。

使用基于XML的配置元数据，您可以使用`replaced-method`元素将已有的方法实现替换为已部署的bean。考虑以下类，它有一个我们想要覆盖的名为`computeValue`的方法：
```
public class MyValueCalculator {

    public String computeValue(String input) {
        // some real code...
    }

    // some other methods...
}
```
实现`org.springframework.beans.factory.support.MethodReplacer`接口的类提供了新的方法定义，如以下示例所示：
```
/**
 * meant to be used to override the existing computeValue(String)
 * implementation in MyValueCalculator
 */
public class ReplacementComputeValue implements MethodReplacer {

    public Object reimplement(Object o, Method m, Object[] args) throws Throwable {
        // get the input value, work with it, and return a computed result
        String input = (String) args[0];
        ...
        return ...;
    }
}
```
部署原始类并指定方法覆盖的bean定义类似于以下示例：
```
<bean id="myValueCalculator" class="x.y.z.MyValueCalculator">
    <!-- arbitrary method replacement -->
    <replaced-method name="computeValue" replacer="replacementComputeValue">
        <arg-type>String</arg-type>
    </replaced-method>
</bean>

<bean id="replacementComputeValue" class="a.b.c.ReplacementComputeValue"/>
```

被替换后的类不在执行`MyValueCalculator`中的computeValue方法，而是执行`ReplacementComputeValue`中`reimplement`方法。

您可以在`<replacement-method />`元素中使用一个或多个`<arg-type />`元素来指示被覆盖的方法的方法签名。仅当方法重载且类中存在多个变体时，才需要参数的签名。
为方便起见，参数的类型字符串可以是完全限定类型名称的子字符串。例如，以下所有匹配java.lang.String：
```
java.lang.String
String
St
```
因为参数的数量通常足以区分每种可能的选择，通过让您只键入与参数类型匹配的最短字符串，此快捷方式可以节省大量输入。

### 1.5 Bean范围 （Bean Scopes）
创建bean定义时，可以创建用于创建由该bean定义定义的类的实际实例的配方。bean定义是一个配方的想法很重要，因为它意味着，与一个类一样，您可以从一个配方创建许多对象实例。

您不仅可以控制要插入到从特定bean定义创建的对象中的各种依赖项和配置值，还可以控制从特定bean定义创建的对象的范围。这种方法功能强大且灵活，因为您可以选择通过配置创建的对象的范围，而不必在Java类级别设置对象的范围。
可以将Bean定义为部署在多个范围之一中。Spring Framework支持六个范围，只有在使用支持Web的ApplicationContext时才有四个范围可用。您还可以创建[自定义范围](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-custom)。

下表描述了支持的范围：

*Table 3. Bean scopes*

Scope|Description
--|:--
singleton|（默认）将单个bean定义范围限定为每个Spring IoC容器的单个对象实例。
prototype| 将单个bean定义范围限定为任意数量的对象实例。
request| 将单个bean定义范围限定为单个HTTP请求的生命周期。也就是说，每个HTTP请求都有自己的bean实例，它是在单个bean定义的后面创建的。仅在Web感知Spring ApplicationContext的上下文中有效(Only valid in the context of a web-aware Spring ApplicationContext.)。
session| 将单个bean定义范围限定为HTTP会话的生命周期。仅在Web感知Spring ApplicationContext的上下文中有效。
application| 将单个bean定义限定为ServletContext的生命周期。仅在Web感知Spring ApplicationContext的上下文中有效。
[websocket](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/web.html#websocket-stomp-websocket-scope)| 将单个bean定义范围限定为WebSocket的生命周期。仅在Web感知Spring ApplicationContext的上下文中有效。

> 从Spring 3.0开始，线程范围可用，但默认情况下未注册：请参阅SimpleThreadScope。从Spring 4.2开始，也可以使用事务范围：SimpleTransactionScope。有关如何注册这些或任何其他自定义作用域的说明，请参阅使用[自定义作用域](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-custom-using)。

#### 1.5.1 单例
只管理单个bean的一个共享实例，并且对具有与该bean定义匹配的ID或ID的bean的所有请求都会导致Spring容器返回一个特定的bean实例。

换句话说，当您定义一个bean definition并将其作为单一作用域时，Spring IoC容器只创建该bean definition定义的对象的一个​​实例。此单个实例存储在此类单例bean的缓存中，并且该命名Bean的所有后续请求和引用都将返回缓存对象。
下图显示了单例范围的工作原理：

![](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/images/singleton.png)

Spring的单例bean概念不同于Gang of Four（GoF）模式书中定义的单例模式。GoF单例对一个对象的范围进行硬编码，使得每个ClassLoader创建一个且只有一个特定类的实例。Spring单例的范围最好描述为每容器和每个bean(也就是说spring中一个类
可以被定义为多个bean，每个bean是单例的，并不是说该类是单例的；而且每个容器中也可以有想同的bean)。这意味着，如果在单个Spring容器中为特定类定义一个bean，则Spring容器将创建该bean definition所定义的类的一个且仅一个实例。
单例范围是Spring中的默认范围。要将bean定义为XML中的单例，您可以定义一个bean，如以下示例所示：
```
<bean id="accountService" class="com.something.DefaultAccountService"/>

<!-- the following is equivalent, though redundant (singleton scope is the default) -->
<bean id="accountService" class="com.something.DefaultAccountService" scope="singleton"/>
```

#### 1.5.2 The Prototype Scope
bean部署的非单例原型范围导致每次发出对该特定bean的请求时都创建新的bean实例。也就是说，bean被注入另一个bean，或者通过对容器的getBean（）方法调用来请求它。通常，您应该对所有有状态bean使用原型范围，对无状态bean使用单例范围。

下图说明了Spring原型范围：

![](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/images/prototype.png)

（数据访问对象（DAO）通常不配置为原型，因为典型的DAO不会保持任何会话状态。我们更容易重用单例图的核心。）

以下示例将bean定义为XML中的原型：

```
<bean id="accountService" class="com.something.DefaultAccountService" scope="prototype"/>
```
与其他范围相比，Spring不管理原型bean的完整生命周期。容器实例化，配置和组装原型对象并将其交给客户端，没有该原型实例的进一步记录。
因此，尽管无论范围如何都在所有对象上调用初始化生命周期回调方法，但在原型的情况下，不会调用已配置的销毁生命周期回调（即prototype不会调用destroy方法）。客户端代码必须清理原型范围的对象并释放原型bean所拥有的昂贵资源。
要使Spring容器释放原型范围的bean所拥有的资源，请尝试使用自定义[bean后置处理器](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-extension-bpp)，它包含对需要清理的bean的引用。

在某些方面，Spring容器关于原型范围bean的角色是Java new运算符的替代品。超过该点的所有生命周期管理必须由客户端处理。 （有关Spring容器中bean的生命周期的详细信息，请参阅[Lifecycle Callbacks](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-lifecycle)。）

#### 1.5.3 单例bean依赖原型bean
当您使用具有依赖于原型bean的单例作用域bean时，请注意在实例化时解析依赖项。因此，如果依赖项将原型范围的bean注入到单例范围的bean中，则会实例化一个新的原型bean，然后将依赖注入到单例bean中。原型实例是唯一提供给单例范围bean的实例

但是，假设您希望单例范围的bean在运行时重复获取原型范围的bean的新实例。您不能将原型范围的bean依赖注入到您的单例bean中，因为当Spring容器实例化单例bean并解析并注入其依赖项时，该注入只发生一次。
如果您需要在运行时多次使用原型bean的新实例，请参阅[方法注入](#1.4.6)。

#### 1.5.4 请求，会话，应用程序和WebSocket范围
仅当您使用Web感知的Spring ApplicationContext实现（例如`XmlWebApplicationContext`）时，请求，会话，应用程序和websocket范围才可用。
如果将这些范围与常规的Spring IoC容器（例如`ClassPathXmlApplicationContext`）一起使用，则会引发未知bean范围的IllegalStateException。

##### Initial Web Configuration
要在请求，会话，应用程序和websocket级别（Web范围的bean）支持bean的范围，在定义bean之前需要一些小的初始配置。（标准范围不需要此初始设置：单例和原型。）

如何完成此初始设置取决于您的特定Servlet环境。

如果您在Spring Web MVC中访问scoped bean，实际上是在Spring `DispatcherServlet`处理的请求中，则无需进行特殊设置。 `DispatcherServlet`已经公开了所有相关状态。

如果您使用Servlet 2.5 Web容器，请求在Spring的`DispatcherServlet`之外处理（例如，使用JSF或Struts时），您需要注册`org.springframework.web.context.request.RequestContextListener ServletRequestListener`。
对于Servlet 3.0+，可以使用WebApplicationInitializer接口以编程方式完成此操作。或者对于旧容器，将以下声明添加到Web应用程序的`web.xml`文件中：
```
<web-app>
    ...
    <listener>
        <listener-class>
            org.springframework.web.context.request.RequestContextListener
        </listener-class>
    </listener>
    ...
</web-app>
```
或者，如果您的侦听器设置存在问题，请考虑使用Spring的`RequestContextFilter`。过滤器映射取决于周围的Web应用程序配置，因此您必须根据需要进行更改。以下清单显示了Web应用程序的过滤器部分：
```
<web-app>
    ...
    <filter>
        <filter-name>requestContextFilter</filter-name>
        <filter-class>org.springframework.web.filter.RequestContextFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>requestContextFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
    ...
</web-app>
```
`DispatcherServlet`，`RequestContextListener`和`RequestContextFilter`做的事完全相同，即将HTTP请求对象绑定到为该请求提供服务的Thread。这使得请求和会话范围的bean可以在调用链的下游进一步使用。

##### Request scope
考虑bean定义的以下XML配置：
```
<bean id="loginAction" class="com.something.LoginAction" scope="request"/>
```
Spring容器通过对每个HTTP请求使用loginAction bean definition来创建LoginAction bean的新实例。也就是说，loginAction bean的范围是HTTP请求级别。您可以根据需要更改创建的实例的内部状态。它们特别针对个人要求。
当请求完成处理时，将放弃作用于请求的bean。

使用注释驱动的组件或Java配置时，可以使用@RequestScope注释将组件分配给请求范围。以下示例显示了如何执行此操作：
```
@RequestScope
@Component
public class LoginAction {
    // ...
}
```

##### Session Scope
考虑bean定义的以下XML配置：
```
<bean id="userPreferences" class="com.something.UserPreferences" scope="session"/>
```
Spring容器通过在单个HTTP会话的生存期内使用`userPreferences` bean definition来创建`UserPreferences` bean的新实例。换句话说，userPreferences bean在HTTP会话级别有效地作用域。
与request scope的bean一样，您可以根据需要更改创建的实例的内部状态，因为同样使用从同一userPreferences bean定义创建的实例的其他HTTP Session实例也不会在状态中看到这些更改，因为它们特定于单个HTTP会话。
丢弃HTTP会话时，也会丢弃作用于该特定HTTP会话的bean。

使用注释驱动的组件或Java配置时，可以使用@SessionScope批注将组件分配给会话范围。
```
@SessionScope
@Component
public class UserPreferences {
    // ...
}
```

##### Application Scope
考虑bean定义的以下XML配置：
```
<bean id="appPreferences" class="com.something.AppPreferences" scope="application"/>
```
Spring容器通过对整个Web应用程序使用`appPreferences` bean定义一次来创建AppPreferences bean的新实例。也就是说，`appPreferences` bean的作用域是`ServletContext`级别，并存储为常规的ServletContext属性。
这有点类似于Spring单例bean，但在两个重要方面有所不同:
* 它是每个ServletContext的单例，而不是每个Spring的'ApplicationContext'（在任何给定的Web应用程序中可能有几个）
* 它实际上是公开的，因此可以看作ServletContext属性

使用注释驱动的组件或Java配置时，可以使用@ApplicationScope批注将组件分配给应用程序范围。以下示例显示了如何执行此操作：
```
@ApplicationScope
@Component
public class AppPreferences {
    // ...
}
```
##### 作为依赖关系的Scoped Bean (Scoped Beans as Dependencies)
Spring IoC容器不仅管理对象（bean）的实例化，还管理协作者（或依赖关系）的连接。如果要将（例如）HTTP request范围的bean注入到寿命较长范围的另一个bean中，您可以选择注入AOP代理来代替范围内的bean。
也就是说，您需要注入一个代理对象，该对象公开与范围对象相同的公共接口，但也可以从相关范围中检索真实目标对象。

> 您还可以在作为单例的作用域的bean之间使用`<aop：scoped-proxy />`，然后引用通过可序列化的中间代理，从而能够在反序列化时重新获取目标单例bean。
> 
> 当针对范围原型的bean声明`<aop：scoped-proxy />`时，共享代理上的每个方法调用都会导致创建一个新的目标实例，然后将该调用转发到该目标实例。
> 
> 此外，范围代理不是以生命周期安全的方式从较短范围访问bean的唯一方法。您还可以将您的注入点（即构造函数或setter参数或自动装配字段）声明为ObjectFactory <MyTargetBean>，允许getObject（）
调用在每次需要时按需检索当前实例 - 而不必保留实例或单独存储它。
>
> 作为扩展变体，您可以声明ObjectProvider <MyTargetBean>，它提供了几个额外的访问变体，包括getIfAvailable和getIfUnique。
>
> JSR-330的变体称为Provider，与每个检索尝试的Provider <MyTargetBean>声明和相应的get（）调用一起使用。有关JSR-330整体的更多详细信息，请参见[此处](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-standard-annotations)。

以下示例中的配置只有一行，但了解“为什么”以及它背后的“如何”非常重要：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop
        https://www.springframework.org/schema/aop/spring-aop.xsd">

    <!-- an HTTP Session-scoped bean exposed as a proxy -->
    <bean id="userPreferences" class="com.something.UserPreferences" scope="session">
        <!-- instructs the container to proxy the surrounding bean -->
        <aop:scoped-proxy/>  // The line that defines the proxy.
    </bean>

    <!-- a singleton-scoped bean injected with a proxy to the above bean -->
    <bean id="userService" class="com.something.SimpleUserService">
        <!-- a reference to the proxied userPreferences bean -->
        <property name="userPreferences" ref="userPreferences"/>
    </bean>
</beans>
```
要创建此类代理，请将子`<aop：scoped-proxy />`元素插入到作用域bean定义中 (see[ Choosing the Type of Proxy to Create](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-scopes-other-injection-proxies) 
and [XML Schema-based configuration](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#xsd-schemas)).
为什么在请求，会话和自定义范围级别定义bean的定义需要`<aop：scoped-proxy />`元素？考虑以下单例bean定义，并将其与您需要为上述范围定义的内容进行对比（请注意，以下userPreferences bean定义不完整）：
```
<bean id="userPreferences" class="com.something.UserPreferences" scope="session"/>

<bean id="userManager" class="com.something.UserManager">
    <property name="userPreferences" ref="userPreferences"/>
</bean>
```
在前面的示例中，单例bean（userManager）注入了对HTTP会话范围的bean（userPreferences）的引用。这里的重点是userManager bean是一个单例：
这里的重点是userManager bean是一个单例：它每个容器只实例化一次，它的依赖项（在这种情况下只有一个，userPreferences bean）也只注入一次。
这意味着userManager bean仅在完全相同的userPreferences对象（即最初注入它的对象）上运行。

当将生命周期较短的scoped bean注入一个寿命较长的scoped bean时，这不是你想要的行为(例如，将HTTP会话范围的协作bean作为依赖项注入到singleton bean中）。
相反，您需要一个`userManager`对象，并且，对于HTTP会话的生命周期，您需要一个特定于HTTP会话的`userPreferences`对象。
因此，容器创建一个对象，该对象公开与UserPreferences类（理想情况下是`UserPreferences`实例的对象）完全相同的公共接口，该对象可以从作用域机制（HTTP请求，会话等）获取真实的`UserPreferences`对象。
容器将此代理对象注入`userManager` bean，该bean不知道此`UserPreferences`引用是代理。在此示例中，当UserManager实例在依赖注入的`UserPreferences`对象上调用方法时，它实际上是在代理上调用方法。
然后，代理从（在这种情况下）HTTP会话中获取真实的`UserPreferences`对象，并将方法调用委托给检索到的真实`UserPreferences`对象。

因此，在将请求和会话范围的bean注入协作对象时，您需要以下（正确和完整）配置，如以下示例所示：
```
<bean id="userPreferences" class="com.something.UserPreferences" scope="session">
    <aop:scoped-proxy/>
</bean>

<bean id="userManager" class="com.something.UserManager">
    <property name="userPreferences" ref="userPreferences"/>
</bean>
```
##### Choosing the Type of Proxy to Create
默认情况下，当Spring容器为使用`<aop：scoped-proxy />`元素标记的bean创建代理时，将创建基于CGLIB的类代理。
> CGLIB代理只拦截公共方法调用！不要在这样的代理上调用非公共方法。它们不会委托给实际的作用域目标对象。

或者，您可以通过为`<aop：scoped-proxy />`元素的proxy-target-class属性的值指定false，将Spring容器配置为为此类作用域bean创建基于JDK接口的标准代理。
使用基于JDK接口的代理意味着您不需要在应用程序类路径中使用其他库来影响此类代理。
但是，这也意味着作用域bean的类必须至少实现一个接口，并且注入了作用域bean的所有协作者必须通过其中一个接口引用bean。以下示例显示了基于接口的代理：
```
<!-- DefaultUserPreferences implements the UserPreferences interface -->
<bean id="userPreferences" class="com.stuff.DefaultUserPreferences" scope="session">
    <aop:scoped-proxy proxy-target-class="false"/>
</bean>

<bean id="userManager" class="com.stuff.UserManager">
    <property name="userPreferences" ref="userPreferences"/>
</bean>
```
有关选择基于类或基于接口的代理的更多详细信息，请参阅[代理机制](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#aop-proxying)。

#### 1.5.5 自定义范围
bean范围机制是可扩展的。您可以定义自己的范围，甚至可以重新定义现有范围，尽管后者被认为是不好的做法，您无法覆盖内置的单例和原型范围。

##### 创建自定义范围
要将自定义作用域集成到Spring容器中，需要实现org.springframework.beans.factory.config.Scope接口，本节将对此进行介绍。
有关如何实现自己的作用域的想法，请参阅Spring Framework本身和[`Scope`](https://docs.spring.io/spring-framework/docs/5.1.6.RELEASE/javadoc-api/org/springframework/beans/factory/config/Scope.html) javadoc提供的Scope实现，它解释了您需要更详细地实现的方法。

Scope接口有四种方法可以从作用域中获取对象，从作用域中删除它们，然后将它们销毁。

例如，会话范围实现返回会话范围的bean（如果它不存在，则该方法在将其绑定到会话以供将来参考之后返回该bean的新实例）。以下方法从基础范围返回对象：
```
Object get(String name, ObjectFactory objectFactory)
```

例如，会话范围实现从基础会话中删除会话范围的bean。应返回该对象，但如果找不到具有指定名称的对象，则可以返回null。以下方法从基础范围中删除对象：
```
Object remove(String name)
```

以下方法记录范围在销毁时或范围中指定对象被销毁时应执行的回调：
```
void registerDestructionCallback(String name, Runnable destructionCallback)
```
有关销毁回调的更多信息，请参阅javadoc或Spring作用域实现。

以下方法获取基础范围的对话标识符：
```
String getConversationId()
```
每个范围的标识符都不同。对于会话范围的实现，该标识符可以是会话标识符。

##### 使用自定义范围
在编写并测试一个或多个自定义Scope实现之后，您需要让Spring容器知道您的新范围。以下方法是使用Spring容器注册新Scope的核心方法：
```
void registerScope(String scopeName, Scope scope);
```
此方法在ConfigurableBeanFactory接口上声明，该接口可通过Spring随附的大多数具体ApplicationContext实现上的BeanFactory属性获得。

registerScope（..）方法的第一个参数是与范围关联的唯一名称。Spring容器本身中的这些名称的示例是singleton和prototype。registerScope（..）方法的第二个参数是您希望注册和使用的自定义Scope实现的实际实例。

假设您编写自定义Scope实现，然后按照下一个示例中的说明进行注册。

> 下一个示例使用SimpleThreadScope，它包含在Spring中，但默认情况下未注册。对于您自己的自定义Scope实现，指令是相同的。

```
Scope threadScope = new SimpleThreadScope();
beanFactory.registerScope("thread", threadScope);
```

然后，您可以创建符合自定义Scope的作用域规则的bean定义，如下所示：
```
<bean id="..." class="..." scope="thread">
```

使用自定义Scope实现，您不仅限于范围的编程注册。您还可以使用CustomScopeConfigurer类以声明方式执行Scope注册，如以下示例所示：

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/aop
        https://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean class="org.springframework.beans.factory.config.CustomScopeConfigurer">
        <property name="scopes">
            <map>
                <entry key="thread">
                    <bean class="org.springframework.context.support.SimpleThreadScope"/>
                </entry>
            </map>
        </property>
    </bean>

    <bean id="thing2" class="x.y.Thing2" scope="thread">
        <property name="name" value="Rick"/>
        <aop:scoped-proxy/>
    </bean>

    <bean id="thing1" class="x.y.Thing1">
        <property name="thing2" ref="thing2"/>
    </bean>

</beans>
```
当您在FactoryBean实现中放置`<aop：scoped-proxy />`时，它是作用域的工厂bean本身，而不是从getObject（）返回的对象。

### 1.6 定制Bean的本质
Spring Framework提供了许多可用于自定义bean特性的接口。本节将它们分组如下：

* [Lifecycle Callbacks](161生命周期回调(lifecycle-callbacks))
* ApplicationContextAware and BeanNameAware
* Other Aware Interfaces

#### **1.6.1 生命周期回调(Lifecycle Callbacks)**
**参与bean生命周期有三种方法**
1. 实现`InitializingBean`和`DisposableBean`接口(spring不推荐，因为有耦合)
2. 使用`@PostConstruct`和`@PreDestroy`注解
3. 使用`init-method`和`destroy-method`

要与容器的bean生命周期管理进行交互，可以实现Spring `InitializingBean`和`DisposableBean`接口。容器为前者调用`afterPropertiesSet()`，为后者调用`destroy()`，让bean在初始化和销毁​​bean时执行某些操作。

> JSR-250 `@PostConstruct`和`@PreDestroy`注释通常被认为是在现代Spring应用程序中接收生命周期回调的最佳实践。
> 
> 使用这些注释意味着您的bean不会耦合到特定于Spring的接口。For details, see Using [@PostConstruct and @PreDestroy](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-postconstruct-and-predestroy-annotations).
> 
>如果您不想使用JSR-250注释但仍想删除耦合，请考虑`init-method`和`destroy-method` bean definition元数据。 

在内部，Spring Framework使用BeanPostProcessor实现类来处理它可以找到的任何回调接口并调用适当的方法。
如果您需要Spring默认提供的自定义功能或其他生命周期行为，您可以自己实现BeanPostProcessor。有关更多信息，请参阅[容器扩展点](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-extension)。

除了初始化和销毁​​回调之外，Spring管理的对象还可以实现`Lifecycle`接口，以便这些对象可以参与启动和关闭过程，这是由容器自身的生命周期驱动的。

本节描述了生命周期回调接口。

##### 初始化回调（Initialization Callbacks）
`org.springframework.beans.factory.InitializingBean`接口允许bean在容器为bean设置所有必需属性后执行初始化工作。 `InitializingBean`接口指定一个方法：
```
void afterPropertiesSet() throws Exception;
```

我们建议您不要使用InitializingBean接口，因为它会不必要地将代码耦合到Spring。或者，我们建议使用`@PostConstruct`注释或指定POJO初始化方法。
对于基于XML的配置元数据，可以使用`init-method`属性指定具有**void无参数签名**的方法的名称。使用Java配置，您可以使用`@Bean`的`initMethod`属性。See [Receiving Lifecycle Callbacks](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-java-lifecycle-callbacks)。 

请考虑以下示例：
```
<bean id="exampleInitBean" class="examples.ExampleBean" init-method="init"/>

public class ExampleBean {

    public void init() {
        // do some initialization work
    }
}
```
前面的示例与以下示例几乎完全相同（包含两个列表）：
```
<bean id="exampleInitBean" class="examples.AnotherExampleBean"/>
public class AnotherExampleBean implements InitializingBean {

    public void afterPropertiesSet() {
        // do some initialization work
    }
}
```
但是，前面两个示例中的第一个没有将代码耦合到Spring

##### 销毁回调（Destruction Callbacks）
实现`org.springframework.beans.factory.DisposableBean`接口允许bean在包含它的容器被销毁时获得回调。 `DisposableBean`接口指定一个方法:
```
void destroy() throws Exception;
```

我们建议您不要使用DisposableBean回调接口，因为它会不必要地将代码耦合到Spring。或者，我们建议使用@PreDestroy注释或指定bean定义支持的泛型方法。使用基于XML的配置元数据，您可以在<bean />上使用destroy-method属性。使用Java配置，您可以使用@Bean的destroyMethod属性。请参阅接收生命周期回调。考虑以下定义：
```
<bean id="exampleInitBean" class="examples.ExampleBean" destroy-method="cleanup"/>
public class ExampleBean {

    public void cleanup() {
        // do some destruction work (like releasing pooled connections)
    }
}
```
前面的定义与以下定义几乎完全相同：
```
<bean id="exampleInitBean" class="examples.AnotherExampleBean"/>

public class AnotherExampleBean implements DisposableBean {

    public void destroy() {
        // do some destruction work (like releasing pooled connections)
    }
}
```
但是，前面两个定义中的第一个没有将代码耦合到Spring。

> 您可以为`<bean>`元素的`destroy-method`属性分配一个特殊值（`inferred`），该值指示Spring自动检测特定bean类的公共`close`或`shotdown`方法。
> 因此，任何实现`java.lang.AutoCloseable`或`java.io.Closeable`的类都将匹配。
> 您还可以在`<beans>`元素的`default-destroy-method`属性上设置此特殊值（`inferred`），以将此行为应用于整组Bean（请参阅[默认初始化和销毁​​方法](#默认初始化和销毁​​方法)）。
> 请注意，这是Java配置的默认行为。


##### 默认初始化和销毁​​方法
当您编写初始化和销毁​​不使用特定于Spring的`InitializingBean`和`DisposableBean`回调接口的方法回调时，通常会编写名称为`init()`，`initialize()`，`dispose()`等的方法。
理想情况下，此类生命周期回调方法的名称在项目中是标准化的，以便所有开发人员使用相同的方法名称并确保一致性。

您可以将Spring容器配置为“look”命名初始化并销毁每个bean上的回调方法名称。这意味着，作为应用程序开发人员，您可以编写应用程序类并使用名为init（）的初始化回调，而无需为每个bean定义配置init-method =“init”属性。
Spring IoC容器在创建bean时调用该方法(并按照前面描述的标准生命周期回调合同)。此功能还强制执行初始化和销毁​​方法回调的一致命名约定。

假设您的初始化回调方法名为init（），而您的destroy回调方法名为destroy（）。然后，您的类类似于以下示例中的类：
```
public class DefaultBlogService implements BlogService {

    private BlogDao blogDao;

    public void setBlogDao(BlogDao blogDao) {
        this.blogDao = blogDao;
    }

    // this is (unsurprisingly) the initialization callback method
    public void init() {
        if (this.blogDao == null) {
            throw new IllegalStateException("The [blogDao] property must be set.");
        }
    }
}
```
然后，您可以在类似于以下内容的bean中使用该类：
```
<beans default-init-method="init">

    <bean id="blogService" class="com.something.DefaultBlogService">
        <property name="blogDao" ref="blogDao" />
    </bean>

</beans>
```

顶级`<beans />`元素属性上存在`default-init-method`属性会导致Spring IoC容器将bean类上的init方法识别为初始化方法回调。当bean被创建和组装时，如果bean类具有这样的方法，则在适当的时候调用它。

您可以使用顶级`<beans />`元素上的default-destroy-method属性，以类似方式（在XML中）配置destroy方法回调。

如果现有bean类已经具有与约定一致的变量命名的回调方法，则可以通过使用`<bean />`的init-method和destroy-method属性指定（在XML中，即）方法名称来覆盖缺省值。
也就是说`<bean/>`的定于优先于`<beans/>`

Spring容器保证在为bean提供所有依赖项后立即调用已配置的初始化回调。因此，在原始bean引用上调用初始化回调，这意味着AOP拦截器等尚未应用于bean。
首先完全创建目标bean，然后应用带有拦截器链的AOP代理（例如,这里只是用aop做例子，还有别的）。如果目标bean和代理是分开定义的，那么您的代码甚至可以绕过代理与原始目标bean交互。
因此，将拦截器应用于init方法是矛盾的，因为这样做会将目标bean的生命周期耦合到其代理或拦截器，并在代码直接与原始目标bean交互时留下奇怪的语义。

##### 组合生命周期机制
从Spring 2.5开始，您有三个控制bean生命周期行为的选项：
* The InitializingBean and DisposableBean callback interfaces
* Custom init() and destroy() methods
* The @PostConstruct and @PreDestroy annotations. 
You can combine these mechanisms to control a given bean.
您可以组合这些机制来控制给定的bean。

> 如果为bean配置了多个生命周期机制，并且每个机制都配置了不同的方法名称，则每个配置的方法都按照此注释后列出的顺序执行。
> 但是，如果为初始化方法配置了相同的方法名称（例如，`init()` - 对于多个这些生命周期机制，该方法将执行一次，如上一节中所述。

为同一个bean配置的多个生命周期机制具有不同的初始化方法，如下所示：

```
1.Methods annotated with @PostConstruct

2.afterPropertiesSet() as defined by the InitializingBean callback interface

3.A custom configured init() method
```
Destroy方法以相同的顺序调用：
```
1.Methods annotated with @PreDestroy

2.destroy() as defined by the DisposableBean callback interface

3.A custom configured destroy() method
```

##### Startup and Shutdown Callbacks
Lifecycle接口为具有自己的生命周期要求的任何对象定义基本方法（例如启动和停止某些后台进程）:
```
public interface Lifecycle {

    void start();

    void stop();

    boolean isRunning();
}
```
然后，当ApplicationContext本身接收到启动和停止信号时（例如，对于运行时的停止/重启场景），它会将这些调用级联到该上下文中定义的所有生命周期实现。
它通过委托LifecycleProcessor完成此操作，如下面的清单所示：
```
public interface LifecycleProcessor extends Lifecycle {

    void onRefresh();

    void onClose();
}
```
请注意，`LifecycleProcessor`本身是`Lifecycle`接口的扩展。它还添加了另外两种方法来响应刷新和关闭的上下文。

> 请注意，常规org.springframework.context.Lifecycle接口是显式启动和停止通知的简单合约，并不意味着在上下文刷新时自动启动。（如果是ApplicationContext，则会将其组件执行生命周期）。
> 要对特定bean的自动启动（包括启动阶段）进行细粒度控制，请考虑实现`org.springframework.context.SmartLifecycle`。
> 
> 此外，请注意，在销毁之前不保证停止通知。在常规关闭时，所有Lifecycle bean首先会在传播常规销毁回调之前收到停止通知。但是，在上下文生命周期中的热刷新或中止刷新尝试时，仅调用destroy方法。

启动和关闭调用的顺序非常重要。如果任何两个对象之间存在“依赖”关系，则依赖方在其依赖之后开始，并且在其依赖之前停止。但是，有时，直接依赖性是未知的。
您可能只知道某种类型的对象应该在另一种类型的对象之前开始。在这些情况下，`SmartLifecycle`接口定义了另一个选项，即在其超级接口`Phased`上定义的`getPhase()`方法。

Phased接口的定义
```
public interface Phased {

    int getPhase();
}
```

以下显示了SmartLifecycle接口的定义：
```
public interface SmartLifecycle extends Lifecycle, Phased {

    boolean isAutoStartup();

    void stop(Runnable callback);

    @Override
    default int getPhase() {
        return DEFAULT_PHASE;
    }
}
```
启动时，具有最低相位的对象首先开始。停止时，遵循相反的顺序。因此，实现`SmartLifecycle`并且其`getPhase()`方法返回`Integer.MIN_VALUE`的对象将是第一个开始和最后一个停止的对象。相反，相位值`Integer.MAX_VALUE`将指示对象应该最后启动并最先停止(可能是因为它依赖于其他进程运行）>
在考虑相位值时，同样重要的是要知道未实现`SmartLifecycle`的任何“正常”Lifecycle对象的默认相位为0。
因此，任何负相位值都表示对象应该在这些标准组件之前启动（并在它们之后停止）。正相值正好相反的。

SmartLifecycle定义的stop方法接受一个callback。在该实现类的关闭过程完成之后，任何实现类都必须调用该callback的`run()`方法。
这样可以在必要时启用异步关闭，因为`LifecycleProcessor`接口的默认实现`DefaultLifecycleProcessor`等待每个阶段内的对象组的超时值来调用该回调。默认的每阶段超时为30秒。
您可以通过在上下文中定义名为`lifecycleProcessor`的bean来覆盖缺省生命周期处理器实例。
如果您只想修改超时，则定义以下内容就足够了：
```
<bean id="lifecycleProcessor" class="org.springframework.context.support.DefaultLifecycleProcessor">
    <!-- timeout value in milliseconds -->
    <property name="timeoutPerShutdownPhase" value="10000"/>
</bean>
```
如前所述，`LifecycleProcessor`接口还定义了用于刷新和关闭上下文的回调方法。后者驱动关闭过程，就像显式调用了`stop()`一样，但是当上下文关闭时会发生。
另一方面，'refresh'回调启用了SmartLifecycle bean的另一个功能。刷新上下文时（在实例化并初始化所有对象之后），将调用该回调。
此时，默认生命周期处理器检查每个`SmartLifecycle`对象的`isAutoStartup()`方法返回的布尔值。
如果为`true`，则在该点启动该对象，而不是等待显式调用上下文或其自己的`start()`方法(与上下文刷新不同，上下文启动不会自动发生在标准上下文实现中)。
如前所述，`phase`值和任何“依赖”关系确定启动顺序。

##### 在非Web应用程序中优雅地关闭Spring IoC容器
> 本节仅适用于非Web应用程序。 Spring的基于Web的`ApplicationContext`可以在相关Web应用程序关闭时正常关闭Spring IoC容器。

如果在非Web应用程序环境中使用Spring的IoC容器(例如，在rich client 桌面环境中)，向JVM注册一个关闭钩子。这样做可确保正常关闭并在单例bean上调用相关的`destroy`方法，以便释放所有资源。
您仍然必须正确配置和实现这些destroy回调。

要注册关闭挂钩，请调用`ConfigurableApplicationContext`接口上声明的`registerShutdownHook()`方法，如以下示例所示：
```
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public final class Boot {

    public static void main(final String[] args) throws Exception {
        ConfigurableApplicationContext ctx = new ClassPathXmlApplicationContext("beans.xml");

        // add a shutdown hook for the above context...
        ctx.registerShutdownHook();

        // app runs here...

        // main method exits, hook is called prior to the app shutting down...
    }
}
```

#### 1.6.2 ApplicationContextAware and BeanNameAware
当`ApplicationContext`创建实现了`org.springframework.context.ApplicationContextAware`接口的对象实例时，将为该实例可以拿到`ApplicationContext`的引用。
以下清单显示了`ApplicationContextAware`接口的定义：
```
public interface ApplicationContextAware {

    void setApplicationContext(ApplicationContext applicationContext) throws BeansException;
}
```
因此，bean可以通过`ApplicationContext`接口以编程方式操作创建它们的`ApplicationContext`，或者通过将引用转换为此接口的已知子类（例如`ConfigurableApplicationContext`，它公开其他功能）。
一种用途是对其他bean进行编程检索。有时这种能力很有用。但是，一般情况下，您应该避免使用它，因为它将代码耦合到Spring并且不遵循Inversion of Control样式(协作者作为属性提供给bean)。
`ApplicationContext`的其他方法提供对文件资源的访问，发布应用程序事件和访问`MessageSource`。这些附加功能在[ApplicationContext的附加功能](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#context-introduction)中描述。

从Spring 2.5开始，自动装配是另一种获取`ApplicationContext`引用的替代方法。“传统”构造函数和byType自动装配模式（如[自动装配协作者](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-autowire)中所述）可以分别为构造函数参数或setter方法参数提供ApplicationContext类型的依赖关系。为了获得更大的灵活性，包括自动装配字段和多参数方法的能力，请使用基于注释的新自动装配功能。
如果这样做，ApplicationContext将自动装入一个字段，构造函数参数或方法参数，如果相关的字段，构造函数或方法带有@Autowired批注，则该参数需要ApplicationContext类型。有关更多信息，请参阅使用[@Autowired](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-autowired-annotation)。

当`ApplicationContext`创建实现`org.springframework.beans.factory.BeanNameAware`接口的类时，将为该类提供对其关联对象定义中定义的名称的引用。以下清单显示了BeanNameAware接口的定义：
```
public interface BeanNameAware {

    void setBeanName(String name) throws BeansException;
}
```
**在普通bean属性的注入之后但在初始化回调（例如`InitializingBean`，`afterPropertiesSet`或自定义init方法）之前调用回调。**

#### 1.6.3 Other Aware Interfaces
除了`ApplicationContextAware`和`BeanNameAware`（前面讨论过）之外，Spring还提供了大量的`Aware`回调接口，让bean向容器指示它们需要某种基础结构依赖性。作为一般规则，名称表示依赖关系类型。下表总结了最重要的`Aware`接口：

*Table 4. Aware interfaces*

名字|注入的依赖|解释
--|:--|:--
ApplicationContextAware|Declaring ApplicationContext.|[ApplicationContextAware and BeanNameAware](#162#applicationcontextaware-and-beanNameaware)
ApplicationEventPublisherAware|封闭ApplicationContext的事件发布者。|[Additional Capabilities of the ApplicationContext](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#context-introduction)
BeanClassLoaderAware|用于加载bean类的类加载器。|[Instantiating Beans](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-factory-class)
BeanFactoryAware|Declaring BeanFactory.|[ApplicationContextAware and BeanNameAware](#162#applicationcontextaware-and-beanNameaware)
BeanNameAware|声明bean的名称|[ApplicationContextAware and BeanNameAware](#162#applicationcontextaware-and-beanNameaware)
BootstrapContextAware|容器运行的资源适配器BootstrapContext。通常仅在支持JCA的ApplicationContext实例中可用。|[JCA CCI](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/integration.html#cci)
LoadTimeWeaverAware|定义的weaver用于在加载时处理类定义。|[Load-time Weaving with AspectJ in the Spring Framework](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#aop-aj-ltw)
MessageSourceAware|用于解析消息的已配置策略（支持参数化和国际化）。|[ApplicationContextAware and BeanNameAware](#162#applicationcontextaware-and-beanNameaware)
NotificationPublisherAware| Spring JMX notification publisher.|[Notifications](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/integration.html#jmx-notifications)
ResourceLoaderAware|配置的加载程序，用于对资源进行低级访问|[Resources](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#resources)
ServletConfigAware|容器运行的当前ServletConfig。仅在Web感知的Spring ApplicationContext中有效。|[Spring MVC](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/web.html#mvc)
ServletContextAware|容器运行的当前ServletContext。仅在Web感知的Spring ApplicationContext中有效。|[Spring MVC](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/web.html#mvc)

请再次注意，使用这些接口会将您的代码绑定到Spring API，而不会遵循Inversion of Control样式。因此，我们建议将它们用于需要以编程方式访问容器的基础架构bean。

### 1.7 Bean Definition 的继承
bean definition可以包含许多配置信息，包括构造函数参数，属性值和特定于容器的信息，例如初始化方法，静态工厂方法名称等。子bean definition从父definition继承配置数据。
子定义可以覆盖某些值或根据需要添加其他值。使用父bean和子bean定义可以节省大量的输入。实际上，这是一种模板形式。

如果以编程方式使用ApplicationContext接口，则子bean定义由`ChildBeanDefinition`类表示。大多数用户不在此级别上使用它们。
相反，它们在类（如`ClassPathXmlApplicationContext`）中以声明方式配置bean定义。
使用基于XML的配置元数据时，可以使用parent属性指定子bean定义，将父bean指定为此属性的值。以下示例显示了如何执行此操作
```
<bean id="inheritedTestBean" abstract="true"
        class="org.springframework.beans.TestBean">
    <property name="name" value="parent"/>
    <property name="age" value="1"/>
</bean>

<bean id="inheritsWithDifferentClass"
        class="org.springframework.beans.DerivedTestBean"
        parent="inheritedTestBean" init-method="initialize">  
    <property name="name" value="override"/>
    <!-- the age property value of 1 will be inherited from parent -->
</bean>
```
如果没有指定，则bean bean定义使用父定义中的bean类，但也可以覆盖它。在下一种例子下，子bean类必须与父类兼容（即，它必须接受父类的属性值）。

子bean定义从父级继承范围，构造函数参数值，属性值和方法覆盖，并带有添加新值的选项。您指定的任何范围，初始化方法，销毁方法或静态工厂方法设置都会覆盖相应的父设置。

其余设置始终取自子定义：depends on，autowire模式，依赖性检查，单例和懒加载。

前面的示例通过使用abstract属性将父bean定义显式标记为abstract。如果父定义未指定类，则需要将父bean定义显式标记为abstract，如以下示例所示：
```
<bean id="inheritedTestBeanWithoutClass" abstract="true">
    <property name="name" value="parent"/>
    <property name="age" value="1"/>
</bean>

<bean id="inheritsWithClass" class="org.springframework.beans.DerivedTestBean"
        parent="inheritedTestBeanWithoutClass" init-method="initialize">
    <property name="name" value="override"/>
    <!-- age will inherit the value of 1 from the parent bean definition-->
</bean>
```
父bean不能单独实例化，因为它不完整，并且也明确标记为抽象。当定义是抽象的时，它仅可用作纯模板bean定义，用作子定义的父定义。
尝试使用这样一个抽象的父bean，通过将它作为另一个bean的ref属性引用或者使用父bean ID进行显式getBean（）调用会返回错误。
类似地，容器的内部`preInstantiateSingletons()`方法忽略定义为abstract的bean定义。

**总结，父定义一般在多个自定义需要相同的bean定义时使用，夫定一无法实例化，所以它不能作为依赖被注入。**

> ApplicationContext默认情况下预先实例化所有单例。因此，重要的是（至少对于单例bean），如果你有一个（父）bean定义，你打算只将其用作模板。
> 这个定义指定了class属性，你必须确保将abstract属性设置为true，否则应用程序上下文将实际（尝试）预先实例化抽象bean。

### 1.8 容器扩展点
通常，应用程序开发人员不需要继承ApplicationContext实现类来做扩展。相反，可以通过插入特殊集成接口的实现来扩展Spring IoC容器。接下来的几节将介绍这些集成接口。

#### 1.8.1 使用BeanPostProcessor自定义Bean
BeanPostProcessor接口定义了可以实现的回调方法，以提供您自己的（或覆盖容器的默认）实例化逻辑，依赖关系解析逻辑等。
如果要在Spring容器完成实例化，配置和初始化bean之后实现某些自定义逻辑，则可以插入一个或多个自定义`BeanPostProcessor`实现。

您可以配置多个`BeanPostProcessor`实例，并且可以通过设置`order`属性来控制这些BeanPostProcessor的执行顺序。仅当`BeanPostProcessor`实现`Ordered`接口时，才能设置此属性。
如果编写自己的`BeanPostProcessor`，则应考虑实现Ordered接口。有关更多详细信息，请参阅[BeanPostProcessor](https://docs.spring.io/spring-framework/docs/5.1.6.RELEASE/javadoc-api/org/springframework/beans/factory/config/BeanPostProcessor.html)和[Ordered](https://docs.spring.io/spring-framework/docs/5.1.6.RELEASE/javadoc-api/org/springframework/core/Ordered.html)接口的javadoc。另请参阅有关[BeanPostProcessor实例的编程注册](#以编程方式注册BeanPostProcessor)的说明。

> `BeanPostProcessor`实例在bean（或对象）实例上操作。也就是说，Spring IoC容器实例化一个bean实例，然后`BeanPostProcessor`完成它们的工作。
> 
> BeanPostProcessor实例的范围是每个容器的范围。仅当您使用容器继承时，这才是相关的。如果在一个容器中定义BeanPostProcessor，它只对该容器中的bean进行后处理。
> 换句话说，在一个容器中定义的bean不会被另一个容器中定义的BeanPostProcessor进行后处理，即使两个容器继承于同一个容器。
> 
> 要更改实际的bean定义（即定义bean的蓝图），您需要使用`BeanFactoryPostProcessor`，如使用`BeanFactoryPostProcessor`定制配置元数据中所述。

`org.springframework.beans.factory.config.BeanPostProcessor`接口由两个回调方法组成。
当一个类被注册为容器的后处理器时，对于容器创建的每个bean实例，后处理器在容器初始化方法（例如`InitializingBean.afterPropertiesSet()`或任何声明的init方法，使用@PostConstruct）之前从容器中获取回调
或者在初始化方法之后回调。后处理器可以对bean实例执行任何操作，包括完全忽略回调。bean后处理器通常检查回调接口，或者它可以用代理包装bean。一些Spring AOP基础结构类实现为bean后处理器，以便提供代理包装逻辑。

`ApplicationContext`自动检测在实现`BeanPostProcessor`接口的配置元数据中定义的任何bean。`ApplicationContext`将这些bean注册为后处理器，以便在创建bean时可以稍后调用它们。
Bean后处理器可以以与任何其他bean相同的方式部署在容器中。

请注意，在配置类上使用`@Bean`工厂方法声明`BeanPostProcessor`时，factory方法的返回类型应该是实现类本身，或者至少是org.springframework.beans.factory.config.BeanPostProcessor接口，清楚地表明该bean的后处理器性质。
否则，ApplicationContext无法在完全创建之前按类型自动检测它。由于`BeanPostProcessor`需要尽早实例化以便应用于上下文中其他bean的初始化，因此这种早期类型检测至关重要。

> <font color="blue" id="以编程方式注册BeanPostProcessor">以编程方式注册`BeanPostProcessor`实例</font>
> 
> 虽然BeanPostProcessor注册的推荐方法是通过`ApplicationContext`自动检测（如前所述），你还是可以使用`ConfigurableBeanFactory`的`addBeanPostProcessor`方法以编程方式注册它们。
> 当您需要在注册前评估条件逻辑或甚至在跨继承的上下文中复制Bean post处理器时，这非常有用。但请注意，以编程方式添加的`BeanPostProcessor`实例不遵循`Ordered`接口。这里，注册的顺序决定了执行的顺序。
> 另请注意，以编程方式注册的BeanPostProcessor实例始终在通过自动检测注册的实例之前处理，而不管任何显式排序。

.

> `BeanPostProcessor`实例和AOP自动代理
> 
> 实现`BeanPostProcessor`接口的类是特殊的，容器会对它们进行不同的处理。作为ApplicationContext的特殊启动阶段的一部分，它们直接引用的所有`BeanPostProcessor`实例和`bean`都在启动时实例化。
> 接下来，所有BeanPostProcessor实例都以排序方式注册，并应用于容器中的所有其他bean。因为AOP自动代理是作为`BeanPostProcessor`本身实现的，所以`BeanPostProcessor`实例和它们直接引用的bean都不符合自动代理的条件，因此没有编入方法
> (也就是说`BeanPostProcessor`的实现类无法使用AOP自动代理)。
> 
> 对于任何此类bean，您应该看到一条信息性日志消息：`Bean someBean is not eligible for getting processed by all BeanPostProcessor interfaces (for example: not eligible for auto-proxying)`。
> 
> 如果您通过使用自动装配或`@Resource`（可能会回退到自动装配）将Bean连接到`BeanPostProcessor`，Spring在搜索类型匹配依赖项候选项时可能会访问意外的bean，因此，它们不适合自动代理或其他类型的bean后置处理。
> 例如，如果您有一个使用@Resource注释的依赖项，其中字段或setter名称不直接对应于bean的声明名称而且没有使用name属性，则Spring会访问其他bean以按类型匹配它们。

以下示例显示如何在`ApplicationContext`中编写，注册和使用`BeanPostProcessor`实例。

##### 示例：Hello World，BeanPostProcessor样式
第一个例子说明了基本用法。该示例显示了一个自定义`BeanPostProcessor`实现，该实现在容器创建时调用每个bean的`toString()`方法，并将生成的字符串输出到系统控制台。

以下清单显示了自定义`BeanPostProcessor`实现类定义：
```
package scripting;

import org.springframework.beans.factory.config.BeanPostProcessor;

public class InstantiationTracingBeanPostProcessor implements BeanPostProcessor {

    // simply return the instantiated bean as-is
    public Object postProcessBeforeInitialization(Object bean, String beanName) {
        return bean; // we could potentially return any object reference here...
    }

    public Object postProcessAfterInitialization(Object bean, String beanName) {
        System.out.println("Bean '" + beanName + "' created : " + bean.toString());
        return bean;
    }
}
```
以下`beans`元素使用`InstantiationTracingBeanPostProcessor`：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:lang="http://www.springframework.org/schema/lang"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/lang
        https://www.springframework.org/schema/lang/spring-lang.xsd">

    <lang:groovy id="messenger"
            script-source="classpath:org/springframework/scripting/groovy/Messenger.groovy">
        <lang:property name="message" value="Fiona Apple Is Just So Dreamy."/>
    </lang:groovy>

    <!--
    when the above bean (messenger) is instantiated, this custom
    BeanPostProcessor implementation will output the fact to the system console
    -->
    <bean class="scripting.InstantiationTracingBeanPostProcessor"/>

</beans>
```
请注意如何仅定义InstantiationTracingBeanPostProcessor。它甚至没有名称，并且，因为它是一个bean，它可以像任何其他bean一样依赖注入。
（前面的配置还定义了一个由Groovy脚本支持的bean。在[动态语言支持](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/languages.html#dynamic-language)一章中详细介绍了Spring动态语言支持。）

以下Java应用程序运行上述代码和配置：
```
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scripting.Messenger;

public final class Boot {

    public static void main(final String[] args) throws Exception {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("scripting/beans.xml");
        Messenger messenger = (Messenger) ctx.getBean("messenger");
        System.out.println(messenger);
    }

}
```
上述应用程序的输出类似于以下内容：
```
Bean 'messenger' created : org.springframework.scripting.groovy.GroovyMessenger@272961
org.springframework.scripting.groovy.GroovyMessenger@272961
```

##### 示例：RequiredAnnotationBeanPostProcessor
将回调接口或注释与自定义`BeanPostProcessor`实现结合使用是扩展Spring IoC容器的常用方法。
一个例子是Spring的RequiredAnationBeanPostProcessor--与Spring发行版一起提供的BeanPostProcessor实现，它确保用（任意）注释标记的bean上的JavaBean属性实际上（配置为）依赖注入值。

#### 使用`BeanFactoryPostProcessor`定制配置元数据
我们看到的下一个扩展点是`org.springframework.beans.factory.config.BeanFactoryPostProcessor`。此接口的语义类似于BeanPostProcessor的语义，有一个主要区别：BeanFactoryPostProcessor对bean配置元数据进行操作。
也就是说，Spring IoC容器允许`BeanFactoryPostProcessor`读取配置元数据，并可能在容器实例化除`BeanFactoryPostProcessor`实例之外的任何bean之前更改它。

您可以配置多个`BeanFactoryPostProcessor`实例，并且可以通过设置`order`属性来控制这些`BeanFactoryPostProcessor`实例的运行顺序。但是，如果`BeanFactoryPostProcessor`实现`Ordered`接口，则只能设置此属性。
如果编写自己的`BeanFactoryPostProcessor`，则应考虑实现`Ordered`接口。有关更多详细信息，请参阅`BeanFactoryPostProcessor`和`Ordered`接口的javadoc。

> 如果要更改实际的bean实例（即，从配置元数据创建的对象），则需要使用`BeanPostProcessor`（前面在使用`BeanPostProcessor`定制Bean中进行了描述）。
> 虽然技术上可以在`BeanFactoryPostProcessor`中使用bean实例（例如，通过使用`BeanFactory.getBean()`），但这样做会导致过早的bean实例化，从而违反标准的容器生命周期。这可能会导致负面影响，例如绕过bean后期处理。
> 
> 此外，`BeanFactoryPostProcessor`实例的范围是每个容器的范围。仅当您使用容器继承时，这才有意义。如果在一个容器中定义`BeanFactoryPostProcessor`，则它仅应用于该容器中的bean定义。
> 一个容器中的Bean定义不会被另一个容器中的`BeanFactoryPostProcessor`实例后处理，即使两个容器都是继承自同一个容器。

bean工厂后处理器在ApplicationContext中声明时自动执行，以便将更改应用于定义容器的配置元数据。Spring包含许多预定义的bean工厂后处理器，例如`PropertyOverrideConfigurer`和`PropertyPlaceholderConfigurer`，`CustomScopeConfigurer`。
您还可以使用自定义`BeanFactoryPostProcessor` - 例如，注册自定义属性编辑器。

`ApplicationContext`自动检测部署到其中的任何实现`BeanFactoryPostProcessor`接口的bean。它在适当的时候使用这些bean作为bean工厂后处理器。您可以像处理任何其他bean一样部署这些后处理器bean。

> 与`BeanPostProcessor`s一样，您通常不希望为`BeanFactoryPostProcessor`s配置懒加载。如果没有其他bean引用`Bean（Factory）PostProcessor`，则该后处理器根本不会被实例化。
> 因此，如果标记了懒加载也会被忽略，即使在`<beans />`元素的声明中将`default-lazy-init`属性设置为`true`，也会急切地实例化`Bean（Factory）PostProcessor`。

##### 示例：类名替换PropertyPlaceholderConfigurer
**从5.2开始，使用PropertySourcesPlaceholderConfigurer，通过利用Environment和PropertySource机制更灵活。**

您可以使用`PropertyPlaceholderConfigurer`通过使用标准Java Properties格式从单独文件中的bean定义外部化属性值。
这样做可以使部署应用程序的人员自定义特定于环境的属性，例如数据库URL和密码，而不会出现修改主XML定义文件或容器文件的复杂性或风险。

请考虑以下基于XML的配置元数据片段，其中定义了具有占位符值的DataSource：
```
<bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
    <property name="locations" value="classpath:com/something/jdbc.properties"/>
</bean>

<bean id="dataSource" destroy-method="close"
        class="org.apache.commons.dbcp.BasicDataSource">
    <property name="driverClassName" value="${jdbc.driverClassName}"/>
    <property name="url" value="${jdbc.url}"/>
    <property name="username" value="${jdbc.username}"/>
    <property name="password" value="${jdbc.password}"/>
</bean>
```
该示例显示了从外部属性文件配置的属性。在运行时，`PropertyPlaceholderConfigurer`应用于替换DataSource的某些属性的元数据。要替换的值被指定为$ {property-name}形式的占位符，它遵循Ant和log4j以及JSP EL样式。

实际值来自标准Java Properties格式的另一个文件：
```
jdbc.driverClassName=org.hsqldb.jdbcDriver
jdbc.url=jdbc:hsqldb:hsql://production:9002
jdbc.username=sa
jdbc.password=root
```
因此，`$ {jdbc.username}`字符串在运行时将替换为值'sa'，并且同样适用于与属性文件中的键匹配的其他占位符值。`PropertyPlaceholderConfigurer`检查bean定义的大多数属性和属性中的占位符。此外，您可以自定义占位符前缀和后缀。

使用Spring 2.5中引入的`context`命名空间，您可以使用专用配置元素配置属性占位符。您可以在location属性中以**逗号**分隔列表的形式提供一个或多个位置，如以下示例所示：
```
<context:property-placeholder location="classpath:com/something/jdbc.properties"/>
```
PropertyPlaceholderConfigurer不仅在您指定的属性文件中查找属性。默认情况下，如果它在指定的属性文件中找不到属性，它还会检查Java System属性。
您可以通过使用以下三个受支持的整数值之一设置configurer的`systemPropertiesMode`属性来自定义此行为：

* `never (0)`: 永远不检查系统属性。
* `fallback(1)`: 如果在指定的属性文件中无法解析，请检查系统属性。这是默认值。
* `override(2)`: 在尝试指定的属性文件之前，首先检查系统属性。这使系统属性可以覆盖任何其他属性源。也就是说如果在系统属性中找到该属性值，就不去指定的属性文件中查找了。

有关更多信息，请参见[PropertyPlaceholderConfigurer](https://docs.spring.io/spring-framework/docs/5.1.6.RELEASE/javadoc-api/org/springframework/beans/factory/config/PropertyPlaceholderConfigurer.html)javadoc。

> 您可以使用PropertyPlaceholderConfigurer中属性值来替换`<bean/>`中的`class`属性，这有时很有用，在您必须在运行时选择特定实现类时。以下示例显示了如何执行此操作：

```
 <bean class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
    <property name="locations">
        <value>classpath:com/something/strategy.properties</value>
    </property>
    <property name="properties">
        <value>custom.strategy.class=com.something.DefaultStrategy</value>
    </property>
</bean>

<bean id="serviceStrategy" class="${custom.strategy.class}"/>
```
> 如果在运行时无法将类解析为有效类，则在即将创建bean时，bean的解析将失败，这是在非lazy-init bean的`ApplicationContext`的`preInstantiateSingletons()`阶段期间。

##### 示例：PropertyOverrideConfigurer
`PropertyOverrideConfigurer`是另一个bean工厂后处理器，类似于`PropertyPlaceholderConfigurer`，但与后者不同，原始定义可以具有默认值，或者根本不具有bean属性的值。
如果重写的`Properties`文件没有某个bean属性值，则使用默认的上下文定义。

请注意，bean定义不知道被覆盖，因此从XML定义文件中可以立即看出正在使用覆盖配置器。如果多个`PropertyOverrideConfigurer`实例为同一个bean属性定义了不同的值，则由于**覆盖机制**，最后一个实例将获胜。

属性文件配置行采用以下格式：
```
beanName.property=value
```
以下清单显示了格式的示例：
```
dataSource.driverClassName=com.mysql.jdbc.Driver
dataSource.url=jdbc:mysql:mydb
```
此示例文件可以与容器定义一起使用，该容器定义包含名为`dataSource`的bean，该bean具有`driver`和`url`属性。

也支持复合属性名称，只要路径的每个组件（重写的最终属性除外）都已经非空（可能由构造函数初始化）。
在下面的示例中，tom bean的`fred`属性的`bob`属性的`sammy`属性设置为标量值123：
```
tom.fred.bob.sammy=123
```

> 指定的覆盖值始终是文字值。它们不会被翻译成bean引用。当XML bean定义中的原始值指定bean引用时，此约定也适用。

使用Spring 2.5中引入的上下文命名空间，可以使用专用配置元素配置属性覆盖，如以下示例所示：
```
<context:property-override location="classpath:override.properties"/>
```

#### 1.8.3 使用FactoryBean自定义实例化逻辑
您可以为本身为工厂的对象实现`org.springframework.beans.factory.FactoryBean`接口。

`FactoryBean`接口是Spring IoC容器实例化逻辑的可插拔点。如果您有复杂的初始化代码，这些代码在Java中表达得更好，而不是（可能）冗长的XML，
您可以创建自己的FactoryBean，在该类中编写复杂的初始化，然后将自定义FactoryBean插入容器中。

`FactoryBean`接口提供了三种方法：

* `Object getObject()`: 返回此工厂创建的对象的实例。可以共享实例，具体取决于此工厂是返回单例还是原型。
* `boolean isSingleton()`: 如果此FactoryBean是单例，则返回true，否则返回false。
* `Class getObjectType()`: 返回`getObject()`方法返回的对象类型，如果事先不知道类型，则返回`null`。

`FactoryBean`概念和接口用于Spring Framework中的许多位置。 FactoryBean接口的50多个实现随Spring一起提供。

当您需要向容器询问实际的`FactoryBean`实例本身而不是它生成的bean时，在调用`ApplicationContext`的`getBean()`方法时，使用`＆`符号作为bean的id前缀。
因此，对于`id`为`myBean`的给定FactoryBean，在容器上调用`getBean("myBean")`将返回FactoryBean的`getObject()`的实例，而调用`getBean("＆myBean")`则返回FactoryBean实例本身。

源码总结

AbstractBeanFactory中获取bean -> doGetBean -> getObjectForBeanInstance 
该bean可能普通bean也可能是factoryBean（FactoryBean前面有`&`符号）

如果是FactoryBean通过FactoryBeanRegisterSupport的getObjectFromFactoryBean获取

### 1.9 基于注解的容器配置
这里的注解只是说使用了@Service这些注解，不是1.12中的javaConfig

<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">注释是否比配置Spring的XML更好？</h3>
    <p>
        基于注释的配置的引入引发了这种方法是否比XML“更好”的问题。简短的回答是“这取决于”。详细的回答是每种方法都有其优点和缺点，通常，由开发人员决定哪种策略更适合他们。
        由于它们的定义方式，注解在其声明中提供了大量上下文，从而导致更短更简洁的配置。但是，XML和代码不耦合，所以也不需要编译。
        一些开发人员更喜欢用代码来注入，而另一些开发人员则认为注解类不再是POJO，而且配置变得分散且难以控制。
        <p></p>
        无论选择如何，Spring都可以兼顾两种风格，甚至可以将它们混合在一起。值得指出的是，通过其`JavaConfig`选项，Spring允许以非侵入方式使用注释，而无需触及目标组件源代码，并且在工具方面，Spring Tool Suite支持所有配置样式。
    </p>
</div>

基于注释的配置提供了XML设置的替代方案，该配置依赖于字节码元数据来连接组件而不是角括号(</>)声明。
开发人员不是使用XML来描述bean连接，而是通过在相关的类，方法或字段声明上使用注释将配置移动到组件类本身。
如示例：`RequiredAnnotationBeanPostProcessor`所述，将`BeanPostProcessor`与注释结合使用是扩展Spring IoC容器的常用方法。例如，Spring 2.0引入了使用`@Required`(5.1中已废弃)注释强制执行所需属性的可能性。
Spring 2.5使得有可能采用相同的通用方法来驱动Spring的依赖注入。从本质上讲，`@Autowired`注释提供的功能与自动装配协作者中描述的相同，但具有更细粒度（xml只能是对于该bean下所有的都执行自动装配，`@Autowired`可以自定义）
的控制和更广泛的适用性。Spring 2.5还增加了对JSR-250注释的支持，例如@ PostConstruct和@PreDestroy。
Spring 3.0增加了对`javax.inject`包中包含的JSR-330（Java的依赖注入）注释的支持，例如`@Inject`和`@Named`。有关这些注释的详细信息，请参阅[相关章节](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-standard-annotations)。

> 注释注入在XML注入之前执行。因此，XML配置会覆盖通过这两种方法连接的属性的注释。

与往常一样，您可以将它们注册为单独的bean定义，但也可以通过在基于XML的Spring配置中包含以下标记来隐式注册它们(注意包含`context`命名空间)。
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">

    <context:annotation-config/>

</beans>
```
（隐式注册的后处理器包括`AutowiredAnnotationBeanPostProcessor`，`CommonAnnotationBeanPostProcessor`，`PersistenceAnnotationBeanPostProcessor`和前面提到的`RequiredAnnotationBeanPostProcessor`。）

> `<context:annotation-config/>`仅在定义它的同一应用程序上下文中查找bean上的注解。
> 这意味着，如果将`<context:annotation-config/>`放在`DispatcherServlet`的`WebApplicationContext`中，它只检查controller中的`@Autowired`bean，而不检查您的services。有关更多信息，请参阅[DispatcherServlet](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/web.html#mvc-servlet)。

##### 1.9.1 @Required
`@Required`注释适用于bean属性setter方法，如下例所示：
```
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Required
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // ...
}
```
此注解指示必须在配置时填充受影响的bean属性，通过bean定义中的显式属性值或通过自动装配。如果尚未填充受影响的bean属性，则容器将引发异常。这允许急切和显式的失败，避免在运行时出现NullPointerException异常。
我们仍然建议您将断言放入bean类本身（例如，进入init方法）。即使您在容器外部使用类，这样做也会强制执行那些必需的引用和值。

> `@Required`注释从Spring Framework 5.1开始正式弃用，更好的方式是使用构造函数注入所需的设置（或者自定义实现`InitializingBean.afterPropertiesSet()`以及bean属性setter方法）。

##### 1.9.2 Using @Autowired
在本节所包含的示例中，可以使用JSR 330的`@Inject`注释代替Spring的`@Autowired`注释。有关详细信息，请参见[此处](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-standard-annotations)。

您可以将`@Autowired`注释应用于构造函数，如以下示例所示：
```
public class MovieRecommender {

    private final CustomerPreferenceDao customerPreferenceDao;

    @Autowired
    public MovieRecommender(CustomerPreferenceDao customerPreferenceDao) {
        this.customerPreferenceDao = customerPreferenceDao;
    }

    // ...
}
```

> 从Spring Framework 4.3开始，如果目标bean只定义了一个开头的构造函数，则不再需要在这样的构造函数上使用@Autowired注释。但是，如果有几个构造器可用，则必须注释至少一个构造器以教导容器使用哪一个。

您还可以将`@Autowired`注释应用于“传统”setter方法，如以下示例所示：
```
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Autowired
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // ...
}
```

您还可以将注释应用于具有任意名称和多个参数的方法，如以下示例所示
```
public class MovieRecommender {

    private MovieCatalog movieCatalog;

    private CustomerPreferenceDao customerPreferenceDao;

    @Autowired
    public void prepare(MovieCatalog movieCatalog,
            CustomerPreferenceDao customerPreferenceDao) {
        this.movieCatalog = movieCatalog;
        this.customerPreferenceDao = customerPreferenceDao;
    }

    // ...
}
```
您也可以将`@Autowired`应用于字段，甚至将其与构造函数混合，如以下示例所示：
```
public class MovieRecommender {

    private final CustomerPreferenceDao customerPreferenceDao;

    @Autowired
    private MovieCatalog movieCatalog;

    @Autowired
    public MovieRecommender(CustomerPreferenceDao customerPreferenceDao) {
        this.customerPreferenceDao = customerPreferenceDao;
    }

    // ...
}
```
> 确保您的目标组件（例如，`MovieCatalog`或`CustomerPreferenceDao`）始终按照用于`@Autowired`-annotated注入​​点的类型(type)声明(也就是说`@Autowried`是按类型查找的)。否则，由于在运行时未找到类型匹配，注入可能会失败。
> 
> 对于通过类路径扫描找到的XML定义的bean或组件类，容器通常预先知道具体类型。但是，对于`@Bean`工厂方法，您需要确保声明的返回类型具有足够的表现力。
> 对于实现多个接口的组件或可能由其实现类型引用的组件，请考虑在工厂方法上声明最具体的返回类型（至少与引用你的bean的注入点所要求的具体相同）。

您还可以通过将注解添加到需要该类型数组的字段或方法，从ApplicationContext提供特定类型的所有bean，如以下示例所示：
```
public class MovieRecommender {

    @Autowired
    private MovieCatalog[] movieCatalogs;

    // ...
}
```
这同样适用于类型化集合，如以下示例所示：
```
public class MovieRecommender {

    private Set<MovieCatalog> movieCatalogs;

    @Autowired
    public void setMovieCatalogs(Set<MovieCatalog> movieCatalogs) {
        this.movieCatalogs = movieCatalogs;
    }

    // ...
}
```
> 如果希望数组或列表中的项按特定顺序排序，则目标bean可以实现org.springframework.core.Ordered接口或使用`@Order`或标准`@Priority`批注。
> 否则，它们的顺序遵循容器中相应目标bean定义的注册顺序。
>
> 您可以在目标类和`@Bean`方法上声明@Order注释，可能是通过单个bean定义（在多个定义使用相同bean类的情况下）。
> @Order值可能会影响注入点的优先级，但要注意它们不会影响单例启动顺序，这是由依赖关系和`@DependsOn`声明确定的正交关注点。
> 
> 请注意，标准的`javax.annotation.Priority`注释在`@Bean`级别不可用，因为它无法在方法上声明。它的语义可以通过`@Order`值与`@Primary`在每个类型的单个bean上进行建模。

只要预期的键类型是`String`，即使是`Map`类型实例也可以自动装配。Map值包含所有期望类型的bean，并且键包含相应的bean名称，如以下示例所示：
```
public class MovieRecommender {

    private Map<String, MovieCatalog> movieCatalogs;

    @Autowired
    public void setMovieCatalogs(Map<String, MovieCatalog> movieCatalogs) {
        this.movieCatalogs = movieCatalogs;
    }

    // ...
}
```
默认情况下，只要零候选bean可用，自动装配就会失败。默认带`@Autowried`的方法，构造函数和字段都需要被注入的。您可以在以下示例中更改此行为：
```
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Autowired(required = false)
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // ...
}
```
> 每个类只能有一个required的构造函数，但可以注释多个non-required 的构造函数。在这种情况下，每个都被认为是候选者之一，Spring使用最贪婪的构造函数，其依赖性可以得到满足 - 也就是说，具有最多参数的构造函数。
> 
> 建议使用`@Autowired`的required属性而不是@`Required`注解。required属性表示该属性不是自动装配所必需的。如果无法自动装配，则会忽略该属性。
> 另一方面，`@Required`更强大，因为它强制执行由容器支持的任何方式设置的属性。如果未注入任何值，则会引发相应的异常。

或者，您可以通过Java 8的`java.util.Optional`表达特定依赖项的非必需特性，如以下示例所示：
```
public class SimpleMovieLister {

    @Autowired
    public void setMovieFinder(Optional<MovieFinder> movieFinder) {
        ...
    }
}
```
从Spring Framework 5.0开始，您还可以使用`@Nullable`注解（任何包中的任何类型 - 例如，来自JSR-305的`javax.annotation.Nullable`）：
```
public class SimpleMovieLister {

    @Autowired
    public void setMovieFinder(@Nullable MovieFinder movieFinder) {
        ...
    }
}
```

您还可以将@Autowired用于众所周知的可解析依赖项的接口:`BeanFactory`, `ApplicationContext`, `Environment`, `ResourceLoader`, `ApplicationEventPublisher`, and `MessageSource`。
这些接口及其扩展接口（如`ConfigurableApplicationContext`或`ResourcePatternResolver`）将自动解析，无需特殊设置。
以下示例自动装配ApplicationContext对象：
```
public class MovieRecommender {

    @Autowired
    private ApplicationContext context;

    public MovieRecommender() {
    }

    // ...
}
```

> `@Autowired`，`@Inject`，`@Value`和`@Resource`注释由Spring `BeanPostProcessor`实现处理。这意味着您无法在自己的`BeanPostProcessor`或`BeanFactoryPostProcessor`类型（如果有）中应用这些注释。
> 必须使用XML或Spring @Bean方法显式地“连接”这些类型。

##### 1.9.3 使用@Primary微调基于注释的自动装配
> 译者添加： 当同时使用@Qualifier注解和@Primary注解时，优先使用@Qualifier注解指定的组件。@Primary的出现能够很好的解决其中一种情况（我的理解）
>
> 可能一开始你只有一个候选者（old），过了一段时间后你又加入了一个候选者(new)，这时候你可能需要使用`@Qualifier`来分别注入，但是这样做有一个问题，比如你的old候选者使用太多了，
> 这会导致修改的代码很多，在这个时候`@Primary`出现了，只要在old候选者上加上`@Primary`，使用改候选者的类就不需要修改了。


由于按类型自动装配可能会有多个候选人，因此通常需要对选择过程进行更多控制。实现这一目标的一种方法是使用Spring的`@Primary`注释。 `@Primary`指示当多个bean可以自动装配到单值依赖项时，应该优先选择特定的bean。
如果候选者中只存在一个@Primary注释的bean，则它将成为自动装配的值。

请考虑以下配置，将`firstMovieCatalog`定义为主要`MovieCatalog`：
```
@Configuration
public class MovieConfiguration {

    @Bean
    @Primary
    public MovieCatalog firstMovieCatalog() { ... }

    @Bean
    public MovieCatalog secondMovieCatalog() { ... }

    // ...
}
```
使用上述配置，以下`MovieRecommender`将与`firstMovieCatalog`一起自动装配：
```
public class MovieRecommender {

    @Autowired
    private MovieCatalog movieCatalog;

    // ...
}
```
相应的bean定义如下：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">

    <context:annotation-config/>

    <bean class="example.SimpleMovieCatalog" primary="true">
        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean class="example.SimpleMovieCatalog">
        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean id="movieRecommender" class="example.MovieRecommender"/>

</beans>
```

##### 1.9.4 使用Qualifiers微调基于注释的自动装配
`@Primary`是一种有效的方法，可以在确定一个主要候选者的情况下按类型使用自动装配。当您需要更多控制选择过程时，可以使用Spring的@Qualifier注释。
您可以将限定符值与特定参数相关联，缩小类型匹配集，以便为每个参数选择特定的bean。
在最简单的情况下，这可以是一个简单的描述性值，如以下示例所示:

```
public class MovieRecommender {

    @Autowired
    @Qualifier("main")
    private MovieCatalog movieCatalog;

    // ...
}
```
您还可以在各个构造函数参数或方法参数上指定`@Qualifier`注释，如以下示例所示：
```
public class MovieRecommender {

    private MovieCatalog movieCatalog;

    private CustomerPreferenceDao customerPreferenceDao;

    @Autowired
    public void prepare(@Qualifier("main") MovieCatalog movieCatalog,
            CustomerPreferenceDao customerPreferenceDao) {
        this.movieCatalog = movieCatalog;
        this.customerPreferenceDao = customerPreferenceDao;
    }

    // ...
}
```
以下示例显示了相应的bean定义:
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">

    <context:annotation-config/> //表示启用注解

    <bean class="example.SimpleMovieCatalog">
        <qualifier value="main"/> //在此例该bean会被注入

        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean class="example.SimpleMovieCatalog">
        <qualifier value="action"/> 

        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean id="movieRecommender" class="example.MovieRecommender"/>

</beans>
```

对于回退匹配，bean名称被视为默认限定符值。因此，您可以使用id而不是嵌套的限定符元素定义bean，从而得到相同的匹配结果。
但是，虽然您可以使用此约定来按名称引用特定bean，但@Autowired基本上是类型驱动注入的。这意味着即使使用bean名称回退，限定符值在类型匹配集中也总是具有缩小的语义。
它们在语义上不表示对唯一bean id的引用。良好的限定符值是`main`或`EMEA`或`persistent`，表示独立于bean id的特定组件的特征，可以在匿名bean定义（例如前面示例中的定义）的情况下自动生成。

限定符也适用于类型化集合，如前所述 - 例如，`Set<MovieCatalog>`。在这种情况下，根据声明的限定符，所有匹配的bean都作为集合注入。这意味着限定符不必是唯一的。相反，它们构成了过滤标准。
例如，您可以使用相同的限定符值“action”定义多个`MovieCatalog` bean，所有这些bean都注入到使用`@Qualifier("action")`注释的`Set<MovieCatalog>`中。

> 在类型匹配候选项中，根据目标bean名称选择限定符值，在注入点不需要@Qualifier注释。
> 如果没有其他解析指示符（例如qualifier或primary标记），则对于非唯一依赖性情况，Spring会将注入点名称（即字段名称或参数名称）与目标bean名称进行匹配，然后选择同名的候选人，如果有的话。
> 
> 也就是说，如果您打算按名称表达注释驱动的注入，请不要主要使用`@Autowired`，即使它能够在类型匹配候选项中通过bean名称进行选择。
> 相反，使用JSR-250 `@Resource`注释，该注释在语义上定义为通过其唯一名称标识特定目标组件，声明的类型与匹配过程无关。
> @Autowired有相当不同的语义：按类型选择候选bean后，仅在那些类型选择的候选项中考虑指定的字符串限定符值(例如，将`account`限定符与标记有相同限定符标签的bean匹配)
> 
> 对于自身定义为集合，Map或数组类型的bean，`@Resource`是一个很好的解决方案，通过唯一名称引用特定的集合或数组bean。
> 也就是说，从4.3版本开始，只要元素类型信息保存在@Bean返回类型签名或集合继承层次结构中，您就可以通过Spring的`@Autowired`类型匹配算法匹配Map和数组类型。
> 在这种情况下，您可以使用限定符值在相同类型的集合中进行选择，如上一段所述。
> 
> 从4.3开始，`@Autowired`也考虑自我引用注入（也就是说，引用回到当前注入的bean）。请注意，自我注入是一种回调。对其他组件的常规依赖性始终具有优先权。
> 从这个意义上说，自我引用并不参与常规的候选人选择，因此不是主要的。相反，它们总是最低优先级。在实践中，您应该仅使用自引用作为最后的手段（例如，通过bean的事务代理调用同一实例上的其他方法）。
> 考虑在这种情况下将受影响的方法分解为单独的委托bean。或者，您可以使用@Resource，它可以通过其唯一名称获取代理回到当前bean。
> 
> @Autowired适用于字段，构造函数和多参数方法，允许在参数级别缩小限定符注释。相比之下，`@Resource`仅支持字段和bean属性具有单个参数的setter方法。
> 因此，如果注射目标是构造函数或多参数方法，则应该使用限定符。

您可以创建自己的自定义限定符注释。为此，请定义注释并在定义中提供`@Qualifier`注解，如以下示例所示：
```
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Qualifier
public @interface Genre {

    String value();
}
```
然后，您可以在自动装配的字段和参数上提供自定义限定符，如以下示例所示：
```
public class MovieRecommender {

    @Autowired
    @Genre("Action")
    private MovieCatalog actionCatalog;

    private MovieCatalog comedyCatalog;

    @Autowired
    public void setComedyCatalog(@Genre("Comedy") MovieCatalog comedyCatalog) {
        this.comedyCatalog = comedyCatalog;
    }

    // ...
}
```
接下来，您可以提供候选bean定义的信息。您可以将`<qualifier />`标记添加为`<bean />`标记的子元素，然后指定与自定义限定符注释匹配的`type`和`value`。`type`与注解的完全限定类名匹配。
或者，为方便起见，如果不存在冲突名称的风险，您可以使用短类名称。以下示例演示了这两种方法：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">

    <context:annotation-config/>

    <bean class="example.SimpleMovieCatalog">
        <qualifier type="Genre" value="Action"/>
        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean class="example.SimpleMovieCatalog">
        <qualifier type="example.Genre" value="Comedy"/>
        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean id="movieRecommender" class="example.MovieRecommender"/>

</beans>
```

在[类路径扫描和托管组件](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-classpath-scanning)中，您可以看到基于注释的替代方法，即在XML中提供限定符元数据。
具体来说，请参阅[使用注释提供限定符元数据](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-scanning-qualifiers)

在某些情况下，使用没有值的注解可能就足够了。当注解用于更通用的目的并且可以应用于多种不同类型的依赖项时，这可能很有用。
例如，您可以提供可在没有Internet连接时搜索的脱机目录。首先，定义简单注释，如以下示例所示：
```
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Qualifier
public @interface Offline {

}

```
然后将注释添加到要自动装配的字段或属性中，如以下示例所示：
```
public class MovieRecommender {

    @Autowired
    @Offline 
    private MovieCatalog offlineCatalog;

    // ...
}
```
现在bean定义只需要一个限定符`type`，如下例所示：
```
<bean class="example.SimpleMovieCatalog">
    <qualifier type="Offline"/> 
    <!-- inject any dependencies required by this bean -->
</bean>
```
您还可以定义除简单值属性之外或代替简单值属性接受命名属性的自定义限定符注释。如果随后在要自动装配的字段或参数上指定了多个属性值，则bean定义必须匹配所有此类属性值才能被视为自动装配候选。例如，请考虑以下注释定义：
```
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
@Qualifier
public @interface MovieQualifier {

    String genre();

    Format format();
}
```
`Format`是一个枚举，定义如下：
```
public enum Format {
    VHS, DVD, BLURAY
}
```

要自动装配的字段使用自定义限定符进行注释，并包含两个属性的值：`genre`和`format`，如以下示例所示：
```
public class MovieRecommender {

    @Autowired
    @MovieQualifier(format=Format.VHS, genre="Action")
    private MovieCatalog actionVhsCatalog;

    @Autowired
    @MovieQualifier(format=Format.VHS, genre="Comedy")
    private MovieCatalog comedyVhsCatalog;

    @Autowired
    @MovieQualifier(format=Format.DVD, genre="Action")
    private MovieCatalog actionDvdCatalog;

    @Autowired
    @MovieQualifier(format=Format.BLURAY, genre="Comedy")
    private MovieCatalog comedyBluRayCatalog;

    // ...
}
```

最后，bean定义应包含匹配的限定符值。此示例还演示了您可以使用bean元属性而不是`<qualifier />`元素。如果可用，`<qualifier />`元素及其属性优先，
但是，如果不存在这样的限定符，则自动装配机制将回退到<meta />标记内提供的值，如以下示例中的最后两个bean定义：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">

    <context:annotation-config/>

    <bean class="example.SimpleMovieCatalog">
        <qualifier type="MovieQualifier">
            <attribute key="format" value="VHS"/>
            <attribute key="genre" value="Action"/>
        </qualifier>
        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean class="example.SimpleMovieCatalog">
        <qualifier type="MovieQualifier">
            <attribute key="format" value="VHS"/>
            <attribute key="genre" value="Comedy"/>
        </qualifier>
        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean class="example.SimpleMovieCatalog">
        <meta key="format" value="DVD"/>
        <meta key="genre" value="Action"/>
        <!-- inject any dependencies required by this bean -->
    </bean>

    <bean class="example.SimpleMovieCatalog">
        <meta key="format" value="BLURAY"/>
        <meta key="genre" value="Comedy"/>
        <!-- inject any dependencies required by this bean -->
    </bean>

</beans>
```

#### 1.9.5 使用泛型作为自动装配限定符
除了`@Qualifier`注释之外，您还可以使用Java泛型类型作为隐式的限定形式。例如，假设您具有以下配置：
```
@Configuration
public class MyConfiguration {

    @Bean
    public StringStore stringStore() {
        return new StringStore();
    }

    @Bean
    public IntegerStore integerStore() {
        return new IntegerStore();
    }
}
```
假设前面的bean实现了一个通用接口（即`Store<String>`和`Store<Integer>`），您可以`@Autowire` Store接口，并将泛型用作限定符，如下例所示：
```
@Autowired
private Store<String> s1; // <String> qualifier, injects the stringStore bean

@Autowired
private Store<Integer> s2; // <Integer> qualifier, injects the integerStore bean
```
通用限定符也适用于自动装配列表，Map实例和数组。以下示例自动装配通用List：
```
// Inject all Store beans as long as they have an <Integer> generic
// Store<String> beans will not appear in this list
@Autowired
private List<Store<Integer>> s;
```

#### 1.9.6 使用CustomAutowireConfigurer
`CustomAutowireConfigurer`是一个`BeanFactoryPostProcessor`，它允许您注册自己的自定义限定符注释类型，即使它们没有使用Spring的`@Qualifier`注释进行注释。以下示例显示如何使用`CustomAutowireConfigurer`：
```
<bean id="customAutowireConfigurer"
        class="org.springframework.beans.factory.annotation.CustomAutowireConfigurer">
    <property name="customQualifierTypes">
        <set>
            <value>example.CustomQualifier</value>
        </set>
    </property>
</bean>
```
`AutowireCandidateResolver`通过以下方式确定autowire候选者：
* 每个bean定义的`autowire-candidate`值
* `<beans />`元素上可用的任何`default-autowire`候选模式
* 存在`@Qualifier`注释以及使用`CustomAutowireConfigurer`注册的任何自定义注释

当多个bean有资格作为`autowire`候选者时，“primary”的确定如下：如果候选者中只有一个bean定义的`primary`属性设置为`true`，则选择它。

#### 1.9.7 使用@Resource注入
Spring还通过对字段或bean属性setter方法使用JSR-250 `@Resource`注释（`javax.annotation.Resource`）来支持注入(不支持构造方法)。这是Java EE中的常见模式：例如，在JSF管理的bean和JAX-WS端点中。

`@Resource`采用name属性。默认情况下，Spring将该值解释为要注入的bean名称。换句话说，它遵循按名称语义，如以下示例所示：
```
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Resource(name="myMovieFinder") 
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }
}
```

如果未明确指定名称，则默认名称是从字段名称或setter方法派生的。如果是字段，则采用字段名称。下面的例子将把名为`movieFinder`的bean注入其setter方法：
```
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Resource
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }
```

> 随注释提供的名称由ApplicationContext解析为bean名称，CommonAnnotationBeanPostProcessor意识到该名称。
> 如果您显式配置Spring的SimpleJndiBeanFactory，则可以通过JNDI解析名称。
> 但是，我们建议您依赖于默认行为并使用Spring的JNDI查找功能来保留间接级别。

在`@Resource`单独使用(一个类只有一个bean)，没有指定明确的名称时，类似于`@Autowired`。`@Resource`找到主要类型匹配而不是特定的命名bean，并解析众所周知的可解析依赖项： 
the BeanFactory, ApplicationContext, ResourceLoader, ApplicationEventPublisher, and MessageSource interfaces。

因此，在以下示例中，`customerPreferenceDao`字段首先查找名为“customerPreferenceDao”的bean，然后返回到`CustomerPreferenceDao`类型的主类型匹配：
```
public class MovieRecommender {

    @Resource
    private CustomerPreferenceDao customerPreferenceDao;

    @Resource
    private ApplicationContext context; //基于已知的可解析依赖类型注入`context`字段：ApplicationContext。

    public MovieRecommender() {
    }

    // ...
}
```

#### 1.9.8 使用@PostConstruct和@PreDestroy
`CommonAnnotationBeanPostProcessor`不仅识别`@Resource`注释，还识别JSR-250生命周期注释：`javax.annotation.PostConstruct`和`javax.annotation.PreDestroy`。
在Spring 2.5中引入，对这些注释的支持提供了初始化回调和销毁回调中描述的生命周期回调机制的替代方法。前提是`CommonAnnotationBeanPostProcessor`在Spring `ApplicationContext`中注册，
承载这些注释之一的方法在生命周期的同一点被调用，作为相应的Spring生命周期接口方法或显式声明的回调方法。在以下示例中，缓存在初始化时预填充并在销毁时清除：
```
public class CachingMovieLister {

    @PostConstruct
    public void populateMovieCache() {
        // populates the movie cache upon initialization...
    }

    @PreDestroy
    public void clearMovieCache() {
        // clears the movie cache upon destruction...
    }
}
```
有关组合各种生命周期机制的效果的详细信息，请参阅[组合生命周期机制](#组合生命周期机制)。

> 与`@Resource`一样，`@PostConstruct`和`@PreDestroy`注释类型是JDK 6到8的标准Java库的一部分。
> 但是，整个javax.annotation包与JDK 9中的核心Java模块分离，最终在JDK 11中删除。如果需要，现在需要通过Maven Central获取`javax.annotation-api`包，只需像任何其他库一样添加到应用程序的类路径中。

### 1.10 类路径扫描和托管组件
本章中的大多数示例都使用XML来指定在Spring容器中生成每个`BeanDefinition`的配置元数据。上一节（基于注释的容器配置）演示了如何通过源级注释提供大量配置元数据。
但是，即使在这些示例中，“基本”bean定义也在XML文件中显式定义，而注释仅驱动依赖项注入。本节介绍通过扫描类路径隐式检测候选组件的选项。
候选组件是与筛选条件匹配的类，并且具有向容器注册的相应bean定义。这消除了使用XML执行bean注册的需要。相反，您可以使用注释（例如，`@Component`），AspectJ类型表达式或您自己的自定义筛选条件来选择哪些类具有向容器注册的bean定义。

> 从Spring 3.0开始，Spring JavaConfig项目提供的许多功能都是核心Spring Framework的一部分。
> 这允许您使用Java而不是使用传统的XML文件来定义bean。有关如何使用这些新功能的示例，请查看`@Configuration`，`@Both`，`@Import`和`@DependsOn`注释。
 

#### 1.10.1 @Component and Further Stereotype Annotations
`@Repository`注释是任何满足存储库角色或构造型的类的标记（也称为数据访问对象或DAO），此标记的用法之一是异常的自动转换，如[异常转换](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/data-access.html#orm-exception-translation)中所述。

Spring提供了进一步的构造型注释：`@Component`，`@Service`和`@Controller`。`@Component`是任何Spring管理组件的通用构造型。
`@Repository`，`@Service`和`@Controller`是@Component的特殊化，用于更具体的用例（分别在持久性，服务和表示层中）。
因此，您可以使用`@Component`注释组件类，但是，通过使用`@Repository`，`@`Service`或`@Controller`注释它们，您的类更适合通过工具处理或与方面关联。例如，这些注释成为切入点的理想目标。
`@Repository`，`@Service`和`@Controller`还可以在Spring Framework的未来版本中携带其他语义。因此，如果您选择在服务层使用`@Component`或`@Service`，`@Service`显然是更好的选择。
同样，如前所述，已经支持@Repository作为持久层中自动异常转换的标记。

#### 1.10.2 使用元注释和组合注释
Spring提供的许多注释都可以在您自己的代码中用作元注释。元注释是可以应用于另一个注释的注释。例如，前面提到的`@Service`注释是使用`@Component`进行元注释的，如下例所示：
```
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component 
public @interface Service {

    // ....
}
```
您还可以组合元注释来创建“组合注释”。例如，Spring MVC的`@RestController`注释由`@Controller`和`@ResponseBody`组成。

此外，组合注释可以选择从元注释重新声明属性以允许自定义。当您只想公开元注释属性的子集时，这可能特别有用。例如，Spring的`@SessionScope`注释将范围名称硬编码到会话，但仍允许自定义`proxyMode`。
以下清单显示了SessionScope批注的定义：
```
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Scope(WebApplicationContext.SCOPE_SESSION)
public @interface SessionScope {

    /**
     * Alias for {@link Scope#proxyMode}.
     * <p>Defaults to {@link ScopedProxyMode#TARGET_CLASS}.
     */
    @AliasFor(annotation = Scope.class)
    ScopedProxyMode proxyMode() default ScopedProxyMode.TARGET_CLASS;

}
```
然后，您可以使用`@SessionScope`而不声明`proxyMode`，如下所示：
```
@Service
@SessionScope
public class SessionScopedService {
    // ...
}
```
您还可以覆盖`proxyMode`的值，如以下示例所示:
```
@Service
@SessionScope(proxyMode = ScopedProxyMode.INTERFACES)
public class SessionScopedUserService implements UserService {
    // ...
}
```
有关更多详细信息，请参阅[Spring Annotation Programming Model](https://github.com/spring-projects/spring-framework/wiki/Spring-Annotation-Programming-Model) wiki页面。

#### 1.10.3 自动检测类和注册Bean定义
Spring可以自动检测构造型类，并使用`ApplicationContext`注册相应的`BeanDefinition`实例。例如，以下两个类符合此类自动检测的条件。
```
@Service
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Autowired
    public SimpleMovieLister(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }
}
```
```
@Repository
public class JpaMovieFinder implements MovieFinder {
    // implementation elided for clarity
}
```
要自动检测这些类并注册相应的bean，需要将`@ComponentScan`添加到`@Configuration`类，其中`basePackages`属性是两个类的公共父包(或者，您可以指定包含每个类的父包的逗号或分号或空格分隔列表。)
```
@Configuration
@ComponentScan(basePackages = "org.example")
public class AppConfig  {
    ...
}
```
> 为简洁起见，前面的示例可能使用了注释的`value`属性（即`@ComponentScan("org.example")`）

以下替代方法使用XML：
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        https://www.springframework.org/schema/context/spring-context.xsd">

    <context:component-scan base-package="org.example"/>

</beans>
```
> 使用`<context：component-scan>`隐式启用`<context：annotation-config>`的功能。使用`<context：component-scan>`时，通常不需要包含`<context：annotation-config>`元素。

> 扫描类路径包需要在类路径中存在相应的目录条目。使用Ant构建JAR时，请确保不要激活JAR任务的仅文件开关。
> 此外，在某些环境中，可能不会基于安全策略公开类路径目录 - 例如，JDK 1.7.0_45及更高版本上的独立应用程序(这需要在您的清单中设置“Trusted-Library信任库” - 请参阅https://stackoverflow.com/questions/19394570/java-jre-7u45-breaks-classloader-getresources)
> 
> 在JDK 9的模块路径（Jigsaw）上，Spring的类路径扫描通常按预期工作。但是，请确保在module-info描述符中导出组件类。
> 如果您希望Spring调用类的非公共成员，请确保它们已“打开”（即，它们在module-info描述符中使用opens声明而不是exports声明）。

此外，使用`component-scan`元素时，将隐式包含`AutowiredAnnotationBeanPostProcessor`和`CommonAnnotationBeanPostProcessor`。这意味着这两个组件是自动检测并连接在一起的 - 所有这些都没有在XML中提供任何bean配置元数据。

> 您可以通过包含值为`false`的`annotation-config`属性来禁用`AutowiredAnnotationBeanPostProcessor`和`CommonAnnotationBeanPostProcessor`的注册。

#### 1.10.4 使用过滤器自定义扫描
默认情况下，使用`@Component`，`@Repository`，`@Service`，`@Controller`注释的类或自身使用`@Component`注释的自定义注释是唯一检测到的候选组件。但是，您可以通过应用自定义筛选器来修改和扩展此行为。
将它们添加为`@ComponentScan`注释的`includeFilters`或`excludeFilters`参数（或作为`component-scan`元素的`include-filter`或`exclude-filter`子元素）。每个filter元素都需要type和expression属性。下表介绍了筛选选项：

*Table 5. Filter Types*

Filter Typer|Example Expression|Description
--|:--|:--
annotation (default)|org.example.SomeAnnotation|要在目标组件中的类型级别出现的注释。
assignable|org.example.SomeClass|目标组件可分配给（扩展或实现）的类（或接口）。
aspectj|org.example..*Service+|要由目标组件匹配的AspectJ类型表达式。
regex|org\\.example\\.Default.*|要由目标组件类名匹配的正则表达式。
custom|org.example.MyTypeFilter|org.springframework.core.type .TypeFilter接口的自定义实现。

以下示例显示忽略所有`@Repository`注释并使用“stub”存储库的配置：
```
@Configuration
@ComponentScan(basePackages = "org.example",
        includeFilters = @Filter(type = FilterType.REGEX, pattern = ".*Stub.*Repository"),
        excludeFilters = @Filter(Repository.class))
public class AppConfig {
    ...
}
```
以下清单显示了等效的XML：
```
<beans>
    <context:component-scan base-package="org.example">
        <context:include-filter type="regex"
                expression=".*Stub.*Repository"/>
        <context:exclude-filter type="annotation"
                expression="org.springframework.stereotype.Repository"/>
    </context:component-scan>
</beans>
```
> 您还可以通过在注释上设置`useDefaultFilters = false`或通过提供`use-default-filters =“false”`作为`<component-scan />`元素的属性来禁用默认过滤器。
> 实际上，这会禁用自动检测使用了`@Component`，`@Repository`，`@Service`，`@Controller`或`@Configuration`注释的类。

#### 1.10.5 在组件中定义Bean元数据
Spring组件还可以向容器提供bean定义元数据。您可以使用用于在`@Configuration`注释类中定义bean元数据的相同`@Bean`注释来执行此操作。以下示例显示了如何执行此操作：
```
@Component
public class FactoryMethodComponent {

    @Bean
    @Qualifier("public")
    public TestBean publicInstance() {
        return new TestBean("publicInstance");
    }

    public void doWork() {
        // Component method implementation omitted
    }
}
```
上面的类是一个Spring组件，在其`doWork（`）方法中具有特定于应用程序的代码。但是，它还提供了一个bean定义，它具有引用publicInstance（）方法的工厂方法。
`@Bean`批注标识工厂方法和其他bean定义属性，例如通过`@Qualifier`批注的限定符值。可以指定的其他方法级注释是`@Scope`，`@Lazy`和自定义限定符注释。

> 除了它的组件初始化角色之外，您还可以将`@Lazy`注释放在标有@Autowired或@Inject的注入点上。在这种情况下，它会导致注入惰性解析代理(延迟注入)。

如前所述，支持自动装配的字段和方法，以及对`@Bean`方法的自动装配的额外支持。以下示例显示了如何执行此操作：
```
@Component
public class FactoryMethodComponent {

    private static int i;

    @Bean
    @Qualifier("public")
    public TestBean publicInstance() {
        return new TestBean("publicInstance");
    }

    // use of a custom qualifier and autowiring of method parameters
    @Bean
    protected TestBean protectedInstance(
            @Qualifier("public") TestBean spouse,
            @Value("#{privateInstance.age}") String country) {
        TestBean tb = new TestBean("protectedInstance", 1);
        tb.setSpouse(spouse);
        tb.setCountry(country);
        return tb;
    }

    @Bean
    private TestBean privateInstance() {
        return new TestBean("privateInstance", i++);
    }

    @Bean
    @RequestScope
    public TestBean requestScopedInstance() {
        return new TestBean("requestScopedInstance", 3);
    }
}
```
该示例将一个名为`privateInstance`的bean上的age属性值自动装配到String方法参数`country`。通过Spring Expression Language的`＃{<expression>}`定义属性的值。
对于`@Value`注释，表达式解析器预先配置为在解析表达式文本时查找bean名称。

从Spring Framework 4.3开始，您还可以声明一个类型为`InjectionPoint`的工厂方法参数（或其更具体的子类：`DependencyDescriptor`）来访问触发创建当前bean的请求注入点。
请注意，这仅适用于实例创建bean实例，而不适用于注入现有实例。因此，此功能对原型范围的bean最有意义。对于其他作用域，工厂方法只能看到触发在给定作用域中创建新bean实例的注入点(例如，触发创建惰性单例bean的依赖项)。
在这种情况下，您可以使用提供的注入点元数据和语义关注。以下示例显示了如何使用InjectionPoint：
```
@Component
public class FactoryMethodComponent {

    @Bean @Scope("prototype")
    public TestBean prototypeInstance(InjectionPoint injectionPoint) {
        return new TestBean("prototypeInstance for " + injectionPoint.getMember());
    }
}
```
常规Spring组件中的`@Bean`方法的处理方式与Spring `@Configuration`类中的对应方式不同。不同之处在于，使用CGLIB不会增强`@Component`类来拦截方法和字段的调用。
CGLIB代理是调用`@Configuration`类中的`@Bean`方法中的方法或字段创建对协作对象的bean元数据引用的方法。
这些方法不是用普通的Java语义调用的，而是通过容器来提供通常的生命周期管理和Spring bean的代理，即使通过对`@Bean`方法的编程调用引用其他bean也是如此。
相反，在普通`@Component`类中调用`@Bean`方法中的方法或字段具有标准Java语义，不应用特殊的CGLIB处理或其他约束。

> 您可以将`@Bean`方法声明为static，允许在不创建包含配置类作为实例的情况下调用它们。这在定义后置处理器bean时特别有意义（例如，BeanFactoryPostProcessor或BeanPostProcessor），
> 因为这样的bean在容器生命周期的早期就被初始化了，并且应该避免在那时触发配置的其他部分。
> 
> 由于技术限制，对静态`@Bean`方法的调用永远不会被容器拦截，甚至在@Configuration类中也不会被拦截（如本节前面所述）：CGLIB子类化只能覆盖非静态方法。
> 因此，直接调用另一个`@Bean`方法具有标准的Java语义，从而导致直接从工厂方法本身返回一个独立的实例。
> 
> `@Bean`方法的Java语言可见性对Spring容器中生成的bean定义没有立即影响。您可以根据需要在非@Configuration类中自由声明工厂方法，也可以在任何地方自由声明静态方法。
> 但是，`@Conffiguration`类中的常规@Bean方法需要可以覆盖 - 也就是说，它们不能声明为private或final。
> 
> `@Bean`方法也可以在给定组件或配置类的基类上发现，也可以在组件或配置类实现的接口中声明的Java 8默认方法上发现。
> 这使得在编写复杂的配置安排时具有很大的灵活性，从Spring 4.2开始，甚至可以通过Java 8默认方法实现多重继承。
> 
> 最后，单个类可以为同一个bean保存多个`@Bean`方法，作为根据运行时可用依赖项使用的多个工厂方法的安排。这与在其他配置方案中选择“最贪婪”构造函数或工厂方法的算法相同：
> 在构造时选择具有最多可满足依赖性的变体，类似于容器在多个@Autowired构造函数之间进行选择的方式。

#### 1.10.6 命名自动检测的组件
当组件作为扫描过程的一部分自动检测时，其bean名称由该扫描程序已知的`BeanNameGenerator`策略生成。
默认情况下，任何包含名称`value`的Spring构造型注释（`@Component`，`@Repository`，`@Service`和`@Controller`）都会将该名称提供给相应的bean定义。

如果此类注释不包含名称值或任何其他检测到的组件（例如自定义过滤器发现的那些组件），则默认bean名称生成器将返回未大写的非限定类名称。
例如，如果检测到以下组件类，则名称将为`myMovieLister`和`movieFinderImpl`：
```
@Service("myMovieLister")
public class SimpleMovieLister {
    // ...
}
```
```
@Repository
public class MovieFinderImpl implements MovieFinder {
    // ...
}
```
> 如果您不想依赖默认的bean命名策略，则可以提供自定义bean命名策略。首先，实现`BeanNameGenerator`接口，并确保包含默认的无参数构造函数。然后，在配置扫描程序时提供完全限定的类名，如以下示例注释和bean定义所示：

```
@Configuration
@ComponentScan(basePackages = "org.example", nameGenerator = MyNameGenerator.class)
public class AppConfig {
    ...
}
```
```
<beans>
    <context:component-scan base-package="org.example"
        name-generator="org.example.MyNameGenerator" />
</beans>
```

作为一般规则，考虑在其他组件可能对其进行显式引用时使用注释指定名称。另一方面，只要容器负责装配，自动生成的名称就足够了。

#### 1.10.7 为自动检测组件提供范围
与Spring管理的组件一样，自动检测组件的默认范围是单例。但是，有时您需要一个可由`@Scope`注释指定的不同范围。您可以在注释中提供范围的名称，如以下示例所示：
```
@Scope("prototype")
@Repository
public class MovieFinderImpl implements MovieFinder {
    // ...
}
```
> `@Scope`注释仅在具体bean类（对于带注释的组件）或工厂方法（对于@Bean方法）上进行了内省。与XML bean定义相比，没有bean定义继承的概念，类级别的继承层次结构与元数据目的无关。

有关特定于Web的范围（如Spring上下文中的“request”或“session”）的详细信息，请参阅[请求，会话，应用程序和WebSocket范围](#154-请求，会话，应用程序和websocket范围)。
与这些范围的预构建注释一样，您也可以使用Spring的元注释方法编写自己的范围注释。例如，使用@Scope（“prototype”）进行元注释的自定义注释，可能还会声明自定义范围代理模式。

> 要为范围解析提供自定义策略而不是依赖基于注释的方法，可以实现ScopeMetadataResolver接口。请确保包含默认的无参数构造函数。然后，您可以在配置扫描程序时提供完全限定的类名，因为以下注释和bean定义示例显示：

```
@Configuration
@ComponentScan(basePackages = "org.example", scopeResolver = MyScopeResolver.class)
public class AppConfig {
    ...
}
```
```
<beans>
    <context:component-scan base-package="org.example" scope-resolver="org.example.MyScopeResolver"/>
</beans>
```

使用某些非单例作用域时，可能需要为作用域对象生成代理。这种推理在[Scoped Beans Dependencies}(#choosing-the-type-of-proxy-to-create)描述了。
为此，component-scan元素上提供了`scoped-proxy`属性。三个可能的值是：`no`，`interfaces`和`targetClass`。例如，以下配置导致标准JDK动态代理：
```
@Configuration
@ComponentScan(basePackages = "org.example", scopedProxy = ScopedProxyMode.INTERFACES)
public class AppConfig {
    ...
}
```
```
<beans>
    <context:component-scan base-package="org.example" scoped-proxy="interfaces"/>
</beans>
```

#### 1.10.8 使用注释提供限定符元数据
在使用[限定符微调基于注释的自动装配](#1.9.4-使用qualifiers微调基于注释的自动装配)中讨论了`@Qualifier`注释。该部分中的示例演示了在解析自动线候选时使用`@Qualifier`注释和自定义限定符注释来提供细粒度控制。
因为这些示例基于XML bean定义，所以通过使用XML中bean元素的`qualifier `或`meta`元素，在候选bean定义上提供限定符元数据。当依靠类路径扫描来自动检测组件时，可以在候选类上为类型级注释提供限定符元数据。
以下三个示例演示了此技术：
```
@Component
@Qualifier("Action")
public class ActionMovieCatalog implements MovieCatalog {
    // ...
}
```
```
@Component
@Genre("Action")
public class ActionMovieCatalog implements MovieCatalog {
    // ...
}
```
```
@Component
@Offline
public class CachingMovieCatalog implements MovieCatalog {
    // ...
}
```
> 与大多数基于注释的替代方案一样，请记住注释元数据绑定到类定义本身，而XML允许多个相同类型的bean在其限定符元数据中提供变体，因为元数据是按实例而不是按类提供的。

#### 1.10.9 生成候选组件索引
虽然类路径扫描速度非常快，但可以通过在编译时创建候选的静态列表来提高大型应用程序的启动性能。在此模式下，所有作为组件扫描目标的模块都必须使用此机制。

> 您现有的`@ComponentScan`或`<context：component-scan>`指令必须保持原样，以请求上下文扫描某些包中的候选项。当ApplicationContext检测到这样的索引时，它会自动使用它而不是扫描类路径。

要生成索引，请为包含组件扫描指令目标的组件的每个模块添加其他依赖项。以下示例显示了如何使用Maven执行此操作：
```
<dependencies>
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context-indexer</artifactId>
        <version>5.1.6.RELEASE</version>
        <optional>true</optional>
    </dependency>
</dependencies>
```
使用Gradle 4.5及更早版本时，应在compileOnly配置中声明依赖项，如以下示例所示：
```
dependencies {
    compileOnly "org.springframework:spring-context-indexer:5.1.6.RELEASE"
}
```
使用Gradle 4.6及更高版本时，应在annotationProcessor配置中声明依赖项，如以下示例所示：
```
dependencies {
    annotationProcessor "org.springframework:spring-context-indexer:5.1.6.RELEASE"
}
```
该过程会在jar文件中生成的`META-INF/spring.components`文件。

> 在IDE中使用此模式时，必须将spring-context-indexer注册为注释处理器，以确保在更新候选组件时索引是最新的。

> 在类路径上找到`META-INF/spring.components`时，将自动启用索引。如果索引部分可用于某些库（或用例），但无法为整个应用程序构建，
> 通过将`spring.index.ignore`设置为`true`，可以作为系统属性或在类路径根目录下的spring.properties文件中，回退到常规类路径排列（就好像根本没有索引）。

### 1.11 使用JSR 330标准注释
从Spring 3.0开始，Spring提供对JSR-330标准注释（依赖注入）的支持。这些注释的扫描方式与Spring注释相同。要使用它们，您需要在类路径中包含相关的jar。

如果你使用的maven，
```
<dependency>
    <groupId>javax.inject</groupId>
    <artifactId>javax.inject</artifactId>
    <version>1</version>
</dependency>
```

#### 1.11.1 使用@Inject和@Named进行依赖注入
您可以使用`@javax.inject.Inject`代替`@Autowired`，如下所示：
```
import javax.inject.Inject;

public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Inject
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    public void listMovies() {
        this.movieFinder.findMovies(...);
        ...
    }
}
```
与@Autowired一样，您可以在字段级别，方法级别和构造函数 - 参数级别使用`@Inject`。此外，您可以将注入点声明为`Provider`，允许按需访问较短范围的bean或通过`Provider.get()`调用对其他bean的延迟访问。
以下示例提供了上述示例的变体：
```
import javax.inject.Inject;
import javax.inject.Provider;

public class SimpleMovieLister {

    private Provider<MovieFinder> movieFinder;

    @Inject
    public void setMovieFinder(Provider<MovieFinder> movieFinder) {
        this.movieFinder = movieFinder;
    }

    public void listMovies() {
        this.movieFinder.get().findMovies(...);
        ...
    }
}
```
如果要为应该注入的依赖项使用限定名称，则应使用`@Named`批注，如下例所示：
```
import javax.inject.Inject;
import javax.inject.Named;

public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Inject
    public void setMovieFinder(@Named("main") MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // ...
}
```

与`@Autowired`一样，`@Inject`也可以与`java.util.Optional`或`@Nullable`一起使用。这在这里更适用，因为`@Inject`没有必需的属性。以下一对示例显示了如何使用 `@Inject`和`@Nullable`：
```
public class SimpleMovieLister {

    @Inject
    public void setMovieFinder(Optional<MovieFinder> movieFinder) {
        ...
    }
}
```
```
public class SimpleMovieLister {

    @Inject
    public void setMovieFinder(@Nullable MovieFinder movieFinder) {
        ...
    }
}
```

#### 1.11.2 @Named和@ManagedBean：@Component注释的标准等价物
您可以使用`@javax.inject.Named`或`javax.annotation.ManagedBean`代替`@Component`，如以下示例所示：
```
import javax.inject.Inject;
import javax.inject.Named;

@Named("movieListener")  // @ManagedBean("movieListener") could be used as well
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Inject
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // ...
}
```
在不指定组件名称的情况下使用`@Component`是很常见的。 `@Named`可以以类似的方式使用，如下例所示：
```
import javax.inject.Inject;
import javax.inject.Named;

@Named
public class SimpleMovieLister {

    private MovieFinder movieFinder;

    @Inject
    public void setMovieFinder(MovieFinder movieFinder) {
        this.movieFinder = movieFinder;
    }

    // ...
}
```
使用`@Named`或`@ManagedBean`时，可以使用与使用Spring注释时完全相同的方式使用组件扫描，如以下示例所示：
```
@Configuration
@ComponentScan(basePackages = "org.example")
public class AppConfig  {
    ...
}
```

> 与`@Component相比`，JSR-330 `@Named`和JSR-250`ManagedBean`注释不可组合。您应该使用Spring的构造型模型来构建自定义组件注释。

#### 1.11.3 JSR-330标准注释的局限性
使用标准注释时，您应该知道某些重要功能不可用，如下表所示：

*Table 6. Spring component model elements versus JSR-330 variants*

Spring|javax.inject.*|javax.inject局限性/评论
|:|:
@Autowired| @Inject|`@Inject`没有'required'属性。可以与Java 8的Optional一起使用。
@Component| @Named / @ManagedBean|JSR-330不提供可组合模型，只是一种识别命名组件的方法。
@Scope("singleton")|@Singleton|JSR-330的默认范围就像Spring的原型。但是，为了使其与Spring的一般默认值保持一致，默认情况下，Spring容器中声明的JSR-330 bean是一个单例。为了使用除单例之外的范围，您应该使用Spring的`@Scope`注释。 javax.inject还提供了`@Scope注释`。然而，这个仅用于创建自己的注释。
@Qualifier| @Qualifier / @Named|javax.inject.Qualifier只是构建自定义限定符的元注释。具体字符串限定符（如Spring的带有值的`@Qualifier`）可以通过javax.inject.Named关联。
@Value|-|没有等价物
@Required|-|没有等价物
@Lazy|-|没有等价物
ObjectFactory|Provider|javax.inject.Provider是Spring的ObjectFactory的直接替代品，只有`get()`方法名称。它也可以与Spring的`@Autowired`结合使用，也可以与非注释的构造函数和setter方法结合使用。

### 1.12 基于Java的容器配置
本节介绍如何在Java代码中使用注释来配置Spring容器。它包括以下主题：

* 基本概念：`@Bean`和`@Configuration`
* 使用`AnnotationConfigApplicationContext`实例化Spring容器
* 使用@Bean注释
* 使用@Configuration注释
* 编写基于Java的配置
* Bean定义配置文件
* PropertySource抽象
* 使用@PropertySource
* 声明中的占位符解决方案

#### 1.12.1 基本概念：`@Bean`和`@Configuration`
Spring的新Java配置支持中的中心工件是`@Configuration`-annotated类和`@Bean`-annotated方法。

`@Bean`注释用于指示方法实例化，配置和初始化由Spring IoC容器管理的新对象。对于那些熟悉Spring的`<beans /> `XML配置的人来说，`@Bean`注释扮演的角色与`<bean />`元素相同。
您可以将`@Bean`-annotated方法与任何Spring `@Component`一起使用。但是，它们最常用于`@Configuration` bean。

使用@Configuration注释类表示其主要目的是作为bean定义的源。此外，`@Configuration`类允许通过调用同一个类中的其他`@Bean`方法来定义bean间依赖关系。最简单的`@Configuration`类如下所示：
```
@Configuration
public class AppConfig {

    @Bean
    public MyService myService() {
        return new MyServiceImpl();
    }
}
```
前面的AppConfig类等效于以下Spring`<beans />`XML：
```
<beans>
    <bean id="myService" class="com.acme.services.MyServiceImpl"/>
</beans>
```
<div style="background-color: #f7f7f8">
    <h3 style="text-align: center;">Full@Configuration vs“lite”@Bean模式？</h3>
    <p>
        当@Bean方法在未使用@Configuration注释的类中声明时，它们被称为以“精简”模式处理。在@Component或甚至普通旧类中声明的Bean方法被认为是“lite”，包含类的主要目的不同，而@Bean方法在那里是一种奖励。
        例如，服务组件可以通过每个适用的组件类上的附加@Bean方法将管理视图公开给容器。在这种情况下，`@Bean`方法是一种通用的工厂方法机制。

    </p>

    <p>
        与完整的`@Configuration不同，lite `@Bean`方法不能声明bean间依赖关系。相反，它们对其包含组件的内部状态进行操作，并且可选地，对它们可以声明的参数进行操作。因此，这样的@Bean方法不应该调用其他@Bean方法。
        每个这样的方法实际上只是特定bean引用的工厂方法，没有任何特殊的运行时语义。这里的积极副作用是不必在运行时应用CGLIB子类，因此在类设计方面没有限制（即，包含类可能是final的，等等）。
    </p>

    <p>
        在常见的场景中，`@Bean`方法将在`@Configuration`类中声明，确保始终使用“full”模式，并因此将交叉方法引用重定向到容器的生命周期管理。
        这可以防止通过常规Java调用意外地调用相同的`@Bean`方法，这有助于减少在“lite”模式下操作时难以跟踪的细微错误。
    </p>
</div>

`@Bean`和`@Configuration`注释将在以下部分中进行深入讨论。首先，我们将介绍使用基于Java的配置创建容器的各种方法。

#### 1.12.2 使用AnnotationConfigApplicationContext实例化Spring容器
以下部分介绍了Spring的`AnnotationConfigApplicationContext`，它是在Spring 3.0中引入的。
这个多功能的`ApplicationContext`实现不仅能够接受`@Configuration`类作为输入，还能接受使用JSR-330元数据注释的类和普通@Component类。

当`@Configuration`类作为输入提供时，`@Consfiguration`类本身被注册为bean定义，并且类中所有声明的`@Bean`方法也被注册为bean定义。

当提供`@Component`和JSR-330类时，它们被注册为bean定义，并且假设在必要时在这些类中使用诸如`@Autowired`或`@Inject`之类的DI元数据

##### 简单的施工
与实例化`ClassPathXmlApplicationContext`时Spring XML文件用作输入的方式非常相似，在实例化`AnnotationConfigApplicationContext`时可以使用`@Configuration`类作为输入。
这允许完全无XML使用Spring容器，如以下示例所示：
```
public static void main(String[] args) {
    ApplicationContext ctx = new AnnotationConfigApplicationContext(AppConfig.class);
    MyService myService = ctx.getBean(MyService.class);
    myService.doStuff();
}
```
如前所述，`AnnotationConfigApplicationContext`不仅限于使用`@Configuration`类。任何`@Component`或JSR-330带注释的类都可以作为输入提供给构造函数，如以下示例所示：
```
public static void main(String[] args) {
    ApplicationContext ctx = new AnnotationConfigApplicationContext(MyServiceImpl.class, Dependency1.class, Dependency2.class);
    MyService myService = ctx.getBean(MyService.class);
    myService.doStuff();
}
```
前面的示例假定`MyServiceImpl`，`Dependency1`和`Dependency2`使用Spring依赖注入注释，例如@Autowired。

##### 使用`register(Class<?>...)`以编程方式构建容器
您可以使用no-arg构造函数实例化`AnnotationConfigApplicationContext`，然后使用`register()`方法对其进行配置。在以编程方式构建`AnnotationConfigApplicationContext`时，此方法特别有用。
以下示例显示了如何执行此操作：
```
public static void main(String[] args) {
    AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext();
    ctx.register(AppConfig.class, OtherConfig.class);
    ctx.register(AdditionalConfig.class);
    ctx.refresh();
    MyService myService = ctx.getBean(MyService.class);
    myService.doStuff();
}
```

##### 使用`scan(String...)`扫描组件
要启用组件扫描，可以按如下方式注释`@Configuration`类：
```
@Configuration
@ComponentScan(basePackages = "com.acme") 
public class AppConfig  {
    ...
}
```
```
<beans>
    <context:component-scan base-package="com.acme"/>
</beans>
```
在前面的示例中，将扫描`com.acme`包以查找任何`@Component`-annotated类，并将这些类注册为容器中的Spring bean定义。
`AnnotationConfigApplicationContext`公开`scan(String ...)`方法以允许相同的组件扫描功能，如以下示例所示：
```
public static void main(String[] args) {
    AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext();
    ctx.scan("com.acme");
    ctx.refresh();
    MyService myService = ctx.getBean(MyService.class);
}
```

> 请记住@Configuration类是使用@Component进行元注释的，因此它们是组件扫描的候选者。在前面的示例中，假设在`com.acme包`（或下面的任何包）中声明了AppConfig，它将在调用`scan()`期间被拾取。
> 在`refresh()`时，它的所有`@Bean`方法都被处理并在容器中注册为bean定义。

##### 使用`AnnotationConfigWebApplicationContext`支持Web应用程序
`AnnotationConfigApplicationContext`的`WebApplicationContext`变体与`AnnotationConfigWebApplicationContext`一起提供。
配置Spring `ContextLoaderListener` servlet侦听器，Spring MVC `DispatcherServlet`等时，可以使用此实现。以下web.xml代码段配置典型的Spring MVC Web应用程序(注意contextClass context-param和init-param的使用):
```
<web-app>
    <!-- Configure ContextLoaderListener to use AnnotationConfigWebApplicationContext
        instead of the default XmlWebApplicationContext -->
    <context-param>
        <param-name>contextClass</param-name>
        <param-value>
            org.springframework.web.context.support.AnnotationConfigWebApplicationContext
        </param-value>
    </context-param>

    <!-- Configuration locations must consist of one or more comma- or space-delimited
        fully-qualified @Configuration classes. Fully-qualified packages may also be
        specified for component-scanning -->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>com.acme.AppConfig</param-value>
    </context-param>

    <!-- Bootstrap the root application context as usual using ContextLoaderListener -->
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>

    <!-- Declare a Spring MVC DispatcherServlet as usual -->
    <servlet>
        <servlet-name>dispatcher</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <!-- Configure DispatcherServlet to use AnnotationConfigWebApplicationContext
            instead of the default XmlWebApplicationContext -->
        <init-param>
            <param-name>contextClass</param-name>
            <param-value>
                org.springframework.web.context.support.AnnotationConfigWebApplicationContext
            </param-value>
        </init-param>
        <!-- Again, config locations must consist of one or more comma- or space-delimited
            and fully-qualified @Configuration classes -->
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>com.acme.web.MvcConfig</param-value>
        </init-param>
    </servlet>

    <!-- map all requests for /app/* to the dispatcher servlet -->
    <servlet-mapping>
        <servlet-name>dispatcher</servlet-name>
        <url-pattern>/app/*</url-pattern>
    </servlet-mapping>
</web-app>
```

#### 1.12.3 使用@Bean注释
@Bean是方法级注释，是XML `<bean />`元素的直接模拟。`@Bean`注释支持`<bean />`提供的一些属性，例如：* `init-method` * `destroy-method` * `autowiring` * `name`。

您可以在`@Configuration`-annotated或`@Component`-annotated类中使用`@Bean`注解。

##### 声明一个bean
要声明bean，可以使用`@Bean`批注对方法进行批注。您可以使用此方法在`ApplicationContext`中注册bean定义。返回值就是bean 定义的类型。默认情况下，bean名称与方法名称相同。以下示例显示了@Bean方法声明：
```
@Configuration
public class AppConfig {

    @Bean
    public TransferServiceImpl transferService() {
        return new TransferServiceImpl();
    }
}
```
上述配置与以下Spring XML完全等效：
```
<beans>
    <bean id="transferService" class="com.acme.TransferServiceImpl"/>
</beans>
```
这两个声明都在`ApplicationContext`中创建一个名为`transferService`的bean，绑定到TransferServiceImpl类型的对象实例，如下图所示：
```
transferService -> com.acme.TransferServiceImpl
```
您还可以使用接口（或基类）返回类型声明您的`@Bean`方法，如以下示例所示：
```
@Configuration
public class AppConfig {

    @Bean
    public TransferService transferService() {
        return new TransferServiceImpl();
    }
}
```
但是，这会将高级类型预测的可见性限制为指定的接口类型（`TransferService`）。然后，只有容器已知的完整类型（TransferServiceImpl）一次，已经实例化了受影响的单例bean。
非延迟单例bean根据其声明顺序进行实例化，因此您可能会看到不同的类型匹配结果，具体取决于另一个组件何时尝试通过非声明类型进行匹配(例如`@Autowired TransferServiceImpl`，只有在`transferService` bean被实例化后才会解析)

> 如果您始终通过声明的服务接口引用您的类型，则`@Bean`返回类型可以安全地加入该设计决策。但是，对于实现多个接口的组件或可能由其实现类型引用的组件，应声明最具体的返回类型
> (至少与引用你的bean的注入点所要求的类型相关)

##### Bean Dependencies
`@Bean`-annotated方法可以有任意数量的参数来描述构建该bean所需的依赖项。例如，如果我们的`TransferService`需要`AccountRepository`，我们可以使用方法参数来实现该依赖关系，如以下示例所示：
```
@Configuration
public class AppConfig {

    @Bean
    public TransferService transferService(AccountRepository accountRepository) {
        return new TransferServiceImpl(accountRepository);
    }
}
```
解析机制与基于构造函数的依赖注入非常相似。有关详细信息，请参阅[相关部分](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-constructor-injection)。

##### 接收生命周期回调
使用`@Bean`注释定义的任何类都支持常规生命周期回调，并且可以使用JSR-250中的`@PostConstruct`和`@PreDestroy`注释。有关更多详细信息，请参阅[JSR-250](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-postconstruct-and-predestroy-annotations)注释。

完全支持常规的Spring生命周期回调。如果bean实现`InitializingBean`，`DisposableBean`或`Lifecycle`，则容器会调用它们各自的方法。

还完全支持标准的`*Aware`接口集（例如`BeanFactoryAware`，`BeanNameAware`，`MessageSourceAware`，`ApplicationContextAware`等）。

`@Bean`批注支持指定任意初始化和销毁​​回调方法，就像bean元素上的Spring XML的`init-method`和`destroy-method`属性一样，如下例所示：
```
public class BeanOne {

    public void init() {
        // initialization logic
    }
}

public class BeanTwo {

    public void cleanup() {
        // destruction logic
    }
}

@Configuration
public class AppConfig {

    @Bean(initMethod = "init")
    public BeanOne beanOne() {
        return new BeanOne();
    }

    @Bean(destroyMethod = "cleanup")
    public BeanTwo beanTwo() {
        return new BeanTwo();
    }
}
```

> 默认情况下，使用Java配置定义的具有公共`close`或`shutdown`方法的bean会自动使用销毁回调登记。
> 如果您有一个公共关闭或关闭方法，并且您不希望在容器关闭时调用它，则可以将`@Bean(destroyMethod = "")`添加到bean定义中以禁用默认（推断）模式。
> 
> 对于使用JNDI获取的资源，您可能希望默认执行此操作，因为其生命周期在应用程序之外进行管理，特别是，请确保始终为DataSource执行此操作，因为已知它在Java EE应用程序服务器上存在问题。
> 
> 以下示例说明如何防止DataSource的自动销毁回调：

```
 @Bean(destroyMethod="")
 public DataSource dataSource() throws NamingException {
    return (DataSource) jndiTemplate.lookup("MyDS");
 }
```
> Also, with @Bean methods, you typically use programmatic JNDI lookups, either by using Spring’s JndiTemplate or JndiLocatorDelegate helpers or straight JNDI InitialContext usage but not the JndiObjectFactoryBean variant (which would force you to declare the return type as the FactoryBean type instead of the actual target type, making it harder to use for cross-reference calls in other @Bean methods that intend to refer to the provided resource here).

对于前面注释中上面示例中的BeanOne，在构造期间直接调用`init()`方法同样有效，如下例所示： 

> 当您直接使用Java工作时，您可以使用对象执行任何您喜欢的操作，并且不必总是依赖于容器生命周期。

##### 指定Bean范围
 Spring包含`@Scope`注释，以便您可以指定bean的范围。

###### 使用@Scope Annotation
您可以指定使用`@Bean`批注定义的bean应具有特定范围。您可以使用Bean Scopes部分中指定的任何标准作用域。

默认范围是单例，但您可以使用`@Scope`覆盖它，如以下示例所示：
```
@Configuration
public class MyConfiguration {

    @Bean
    @Scope("prototype")
    public Encryptor encryptor() {
        // ...
    }
}
```
###### @Scope和scoped-proxy
Spring提供了一种通过[scoped proxies](#作为依赖关系的scoped-bean-scoped-beans-as-dependencies)处理作用域依赖项的便捷方法。使用XML配置时创建此类代理的最简单方法是`<aop:scoped-proxy />`元素。
使用`@Scope`在Java中配置bean使用`proxyMode`属性。默认值为无代理（`ScopedProxyMode.NO`），但您可以指定`ScopedProxyMode.TARGET_CLASS`或`ScopedProxyMode.INTERFACES`。

如果使用Java将XML参考文档（请参阅作用域代理）的作用域代理示例移植到我们的`@Bean`，它类似于以下内容：
```
// an HTTP Session-scoped bean exposed as a proxy
@Bean
@SessionScope
public UserPreferences userPreferences() {
    return new UserPreferences();
}

@Bean
public Service userService() {
    UserService service = new SimpleUserService();
    // a reference to the proxied userPreferences bean
    service.setUserPreferences(userPreferences());
    return service;
}
```

###### 自定义Bean命名
默认情况下，配置类使用`@Bean`方法的名称作为bean的名称。但是，可以使用`name`属性覆盖此功能，如以下示例所示：
```
@Configuration
public class AppConfig {

    @Bean(name = "myThing")
    public Thing thing() {
        return new Thing();
    }
}
```
###### bean别名
就像[bean的命名](#131-bean的命名)中所讨论的，有时需要为单个bean提供多个名称，也称为bean别名。`@Bean`批注的`name`属性可以接收一个String数组。以下示例显示如何为bean设置多个别名：
```
@Configuration
public class AppConfig {

    @Bean({"dataSource", "subsystemA-dataSource", "subsystemB-dataSource"})
    public DataSource dataSource() {
        // instantiate, configure and return DataSource bean...
    }
}
```

###### bean描述
有时，提供更详细的bean文本描述会很有帮助。当bean（可能通过JMX）进行监视时，这可能特别有用。

要向`@Bean`添加描述，可以使用`@Description`注解，如以下示例所示：
```
@Configuration
public class AppConfig {

    @Bean
    @Description("Provides a basic example of a bean")
    public Thing thing() {
        return new Thing();
    }
}
```

#### 1.12.4 使用@Configuration注解
`@Configuration`是一个类级别注释，指示对象是bean定义的来源。`@Configuration`类通过公共`@Bean`注解的方法声明bean。在`@Configuration`类上调用@Bean方法也可用于定义bean间依赖关系。
有关一般介绍，请参阅基本概念：`@Bean`和`@Configuration`。

##### 注入bean间依赖关系
当bean彼此依赖时，表达该依赖关系就像让一个bean方法调用另一个bean一样简单，如下例所示：
```
@Configuration
public class AppConfig {

    @Bean
    public BeanOne beanOne() {
        return new BeanOne(beanTwo());
    }

    @Bean
    public BeanTwo beanTwo() {
        return new BeanTwo();
    }
}
```
在前面的示例中，`beanOne`通过构造函数注入接收对`beanTwo`的引用。

> 这种声明bean间依赖关系的方法只有在`@Configuration`类中声明@Bean方法时才有效。您不能使用普通的`@Component`类声明bean间依赖关系。

##### Lookup方法注入
如前所述，[lookup方法注入](#146-方法注入)是一项很少使用的高级功能。在单例范围的bean依赖于原型范围的bean的情况下，它很有用。将Java用于此类配置提供了实现此模式的自然方法。以下示例显示如何使用查找方法注入：
```
public abstract class CommandManager {
    public Object process(Object commandState) {
        // grab a new instance of the appropriate Command interface
        Command command = createCommand();
        // set the state on the (hopefully brand new) Command instance
        command.setState(commandState);
        return command.execute();
    }

    // okay... but where is the implementation of this method?
    protected abstract Command createCommand();
}
```
通过使用Java配置，您可以创建`CommandManager`的子类，其中抽象的`createCommand()`方法被覆盖，以便查找新的（prototype）命令对象。以下示例显示了如何执行此操作：
```
@Bean
@Scope("prototype")
public AsyncCommand asyncCommand() {
    AsyncCommand command = new AsyncCommand();
    // inject dependencies here as required
    return command;
}

@Bean
public CommandManager commandManager() {
    // return new anonymous implementation of CommandManager with createCommand()
    // overridden to return a new prototype Command object
    return new CommandManager() {
        protected Command createCommand() {
            return asyncCommand();
        }
    }
}
```

##### 有关基于Java的配置如何在内部工作的更多信息
请考虑以下示例，该示例显示了被调用两次的`@Bean`注释方法：
```
@Configuration
public class AppConfig {

    @Bean
    public ClientService clientService1() {
        ClientServiceImpl clientService = new ClientServiceImpl();
        clientService.setClientDao(clientDao());
        return clientService;
    }

    @Bean
    public ClientService clientService2() {
        ClientServiceImpl clientService = new ClientServiceImpl();
        clientService.setClientDao(clientDao());
        return clientService;
    }

    @Bean
    public ClientDao clientDao() {
        return new ClientDaoImpl();
    }
}
```
`clientDao()`在`clientService1()`中调用一次，在`clientService2()`中调用一次。由于此方法创建`ClientDaoImpl`的新实例并将其返回，因此通常希望有两个实例（每个服务一个）。
这肯定会有问题：在Spring中，实例化的bean默认具有单例范围。这就是魔术的来源：所有`@Configuration`类在启动时都使用CGLIB进行子类化。
在子类中，子方法在调用父方法并创建新实例之前，首先检查容器是否有任何缓存（作用域）bean。

> 根据bean的范围，行为可能会有所不同。我们在这里谈论单例。

> 从Spring 3.2开始，不再需要将CGLIB添加到类路径中，因为CGLIB类已经在`org.springframework.cglib`下重新打包并直接包含在`spring-core` JAR中。

> 由于CGLIB在启动时动态添加功能，因此存在一些限制。特别是，配置类不能是最终的。但是，从4.3开始，配置类允许使用任何构造函数，包括使用`@Autowired`或单个非默认构造函数声明进行默认注入。
> 如果您希望避免任何CGLIB强加的限制，请考虑在非`@Configuration`类上声明您的`@Bean`方法（例如，在普通的`@Component`类上）。
> 然后不会拦截`@Bean`方法之间的跨方法调用，因此您必须在构造函数或方法级别专门依赖依赖项注入。

#### 1.12.5 组合基于Java的配置
Spring的基于Java的配置功能允许您撰写注释，这可以降低配置的复杂性。

##### 使用@Import注解
就像在Spring XML文件中使用`<import />`元素来帮助模块化配置一样，`@Import`注释允许从另一个配置类中加载`@Bean`定义，如下例所示：
```
@Configuration
public class ConfigA {

    @Bean
    public A a() {
        return new A();
    }
}

@Configuration
@Import(ConfigA.class)
public class ConfigB {

    @Bean
    public B b() {
        return new B();
    }
}
```
现在，在实例化上下文时，不需要同时指定`ConfigA.class`和`ConfigB.class`，只需要显式提供`ConfigB`，如下例所示：
```
public static void main(String[] args) {
    ApplicationContext ctx = new AnnotationConfigApplicationContext(ConfigB.class);

    // now both beans A and B will be available...
    A a = ctx.getBean(A.class);
    B b = ctx.getBean(B.class);
}
```
这种方法简化了容器实例化，因为只需要处理一个类，而不是要求您在构造期间记住可能大量的`@Configuration类`。

> 从Spring Framework 4.2开始，`@Import`还支持引用常规组件类，类似于`AnnotationConfigApplicationContext.register`方法。
> 如果要避免组件扫描，这一点特别有用，可以使用一些配置类作为明确定义所有组件的入口点。

##### 在导入的@Bean定义上注入依赖项
前面的例子有效，但很简单。在大多数实际情况中，bean跨配置类彼此依赖。使用XML时，这不是问题，因为不涉及编译器，您可以声明`ref = "someBean"`并信任Spring在容器初始化期间解决它。
使用`@Configuration`类时，Java编译器会对配置模型施加约束，因为对其他bean的引用必须是有效的Java语法。

幸运的是，解决这个问题很简单。正如我们已经讨论过的，`@Bean`方法可以有任意数量的参数来描述bean的依赖关系。
考虑以下更多真实场景​​，其中包含几个@Configuration类，每个类都依赖于在其他类中声明的bean：
```
@Configuration
public class ServiceConfig {

    @Bean
    public TransferService transferService(AccountRepository accountRepository) {
        return new TransferServiceImpl(accountRepository);
    }
}

@Configuration
public class RepositoryConfig {

    @Bean
    public AccountRepository accountRepository(DataSource dataSource) {
        return new JdbcAccountRepository(dataSource);
    }
}

@Configuration
@Import({ServiceConfig.class, RepositoryConfig.class})
public class SystemTestConfig {

    @Bean
    public DataSource dataSource() {
        // return new DataSource
    }
}

public static void main(String[] args) {
    ApplicationContext ctx = new AnnotationConfigApplicationContext(SystemTestConfig.class);
    // everything wires up across configuration classes...
    TransferService transferService = ctx.getBean(TransferService.class);
    transferService.transfer(100.00, "A123", "C456");
}
```
还有另一种方法可以达到相同的效果。请记住，`@Configuration`类本质上只是容器中的另一个bean：
这意味着他们可以利用`@Autowired`和`@Value`注入以及与任何其他bean相同的其他功能。

> 确保以这种方式注入的依赖项只是最简单的类型。`@Configuration`类在上下文初始化期间很早就被处理，并且强制以这种方式注入依赖项可能导致意外的早期初始化。尽可能采用基于参数的注入，如前面的示例所示。
> 
> 另外，要特别注意通过`@Bean`来定义`BeanPostProcessor`和`BeanFactoryPostProcessor`。在声明这些bean定义时通常应该声明为静态`@Bean`方法，而不是触发其包含配置类的实例化。
> 否则，`@Autowired`和`@Value`不能在配置类本身上工作，因为它过早地被创建为bean实例。

以下示例显示了如何将一个bean自动连接到另一个bean
```
@Configuration
public class ServiceConfig {

    @Autowired
    private AccountRepository accountRepository;

    @Bean
    public TransferService transferService() {
        return new TransferServiceImpl(accountRepository);
    }
}

@Configuration
public class RepositoryConfig {

    private final DataSource dataSource;

    @Autowired
    public RepositoryConfig(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Bean
    public AccountRepository accountRepository() {
        return new JdbcAccountRepository(dataSource);
    }
}

@Configuration
@Import({ServiceConfig.class, RepositoryConfig.class})
public class SystemTestConfig {

    @Bean
    public DataSource dataSource() {
        // return new DataSource
    }
}

public static void main(String[] args) {
    ApplicationContext ctx = new AnnotationConfigApplicationContext(SystemTestConfig.class);
    // everything wires up across configuration classes...
    TransferService transferService = ctx.getBean(TransferService.class);
    transferService.transfer(100.00, "A123", "C456");
}
```

> 仅在Spring Framework 4.3中支持`@Configuration`类中的构造函数注入。另请注意，如果目标bean仅定义了一个构造函数，则无需指定`@Autowired`。在前面的示例中，`RepositoryConfig`构造函数中不需要`@Autowired`。

##### 完全符合条件的导入bean，便于导航
在前面的场景中，使用`@Autowired`可以很好地工作并提供所需的模块化，但确定声明自动装配的bean定义的确切位置仍然有些模棱两可。
例如，作为一名开发人员你要查找`ServiceConfig`，您如何确切地知道`@Autowired AccountRepository` bean的声明位置？它在代码中并不明确，这可能就好了。
请记住，Spring Tool Suite提供的工具可以呈现图形，显示所有内容的连线方式，这可能就是您所需要的。
此外，您的Java IDE可以轻松找到`AccountRepository`类型的所有声明和用法，并快速显示返回该类型的`@Bean`方法的位置。

如果这种歧义不可接受并且您希望在IDE中从一个`@Configuration`类直接导航到另一个`@Configuration`类，请考虑自行装配配置类本身。以下示例显示了如何执行此操作：
```
@Configuration
public class ServiceConfig {

    @Autowired
    private RepositoryConfig repositoryConfig;

    @Bean
    public TransferService transferService() {
        // navigate 'through' the config class to the @Bean method!
        return new TransferServiceImpl(repositoryConfig.accountRepository());
    }
}
```

在前面的情况中，定义`AccountRepository`是完全明确的。但是，`ServiceConfig`现在与`RepositoryConfig紧密耦合。这是权衡。
通过使用基于接口的或基于类的抽象`@Configuration类`，可以在某种程度上减轻这种紧密耦合。请考虑以下示例：
```
@Configuration
public class ServiceConfig {

    @Autowired
    private RepositoryConfig repositoryConfig;

    @Bean
    public TransferService transferService() {
        return new TransferServiceImpl(repositoryConfig.accountRepository());
    }
}

@Configuration
public interface RepositoryConfig {

    @Bean
    AccountRepository accountRepository();
}

@Configuration
public class DefaultRepositoryConfig implements RepositoryConfig {

    @Bean
    public AccountRepository accountRepository() {
        return new JdbcAccountRepository(...);
    }
}

@Configuration
@Import({ServiceConfig.class, DefaultRepositoryConfig.class})  // import the concrete config!
public class SystemTestConfig {

    @Bean
    public DataSource dataSource() {
        // return DataSource
    }

}

public static void main(String[] args) {
    ApplicationContext ctx = new AnnotationConfigApplicationContext(SystemTestConfig.class);
    TransferService transferService = ctx.getBean(TransferService.class);
    transferService.transfer(100.00, "A123", "C456");
}
```

现在，`ServiceConfig`与具体的`DefaultRepositoryConfig`松散耦合，内置的IDE工具仍然很有用：您可以轻松获得RepositoryConfig实现的类型层次结构。
通过这种方式，导航`@Configuration`类及其依赖项与导航基于接口的代码的常规过程没有什么不同。

> 如果要影响某些bean的启动创建顺序，请考虑将其中一些声明为`@Lazy`（用于在首次访问时创建而不是在启动时）或@DependsOn某些其他bean（确保在其之前创建特定的其他bean）当前的bean，超出后者的直接依赖性所暗示的）。

##### 有条件地包含@Configuration类或@Bean方法
基于某些任意系统状态，有条件地启用或禁用完整的`@Configuration`类甚至单个`@Bean`方法通常很有用。
一个常见的例子是，只有在Spring `Environment`中启用了特定的profile时才使用`@Profile`注释来激活bean（有关详细信息，请参阅[Bean Definition Profiles](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-definition-profiles)）。

`@Profile`注释实际上是通过使用更灵活的注释`@Conditional`实现的。`@Conditional`注释表示在注册`@Bean`之前应该参考的特定`org.springframework.context.annotation.Condition`实现。
`Condition`接口的实现提供了一个返回`true`或`false`的`matches（...）`方法。例如，以下列表显示了用于`@Profile`的实际`Condition`实现：

有关更多详细信息，请参阅[`@Conditional`](https://docs.spring.io/spring-framework/docs/5.1.6.RELEASE/javadoc-api/org/springframework/context/annotation/Conditional.html) javadoc。

##### 结合Java和XML配置
Spring的`@Configuration`类支持并非旨在成为Spring XML的100％完全替代品。某些工具（如Spring XML命名空间）仍然是配置容器的理想方法。
在XML方便或必要的情况下，您可以选择：使用“以XML为中心”的方式实例化容器，例如，`ClassPathXmlApplicationContext`，或者通过使用`AnnotationConfigApplicationContext`和`@ImportResource`注释以“Java中心”方式实例化它，以根据需要导入XML。

###### 以XML为中心使用@Configuration类
最好从XML引导Spring容器，并以ad-hoc方式包含`@Configuration类`。例如，在使用Spring XML的大型现有代码库中，可以根据需要更轻松地创建`@Configuration类`，并将其包含在现有XML文件中。
在本节的后面部分，我们将介绍在这种“以XML为中心”的情况下使用`@Configuration`类的选项。

###### 将@Configuration类声明为普通的Spring `<bean />`元素
请记住，`@Configuration`类本质上是容器中的bean定义。在本系列示例中，我们创建一个名为`AppConfig`的`@Configuration`类，并将其作为`<bean />`定义包含在`system-test-config.xml`中。
由于`<context：annotation-config />`已打开，容器会识别`@Configuration`注解并正确处理`AppConfig`中声明的`@Bean`方法。

以下示例显示了Java中的普通配置类：
```
@Configuration
public class AppConfig {

    @Autowired
    private DataSource dataSource;

    @Bean
    public AccountRepository accountRepository() {
        return new JdbcAccountRepository(dataSource);
    }

    @Bean
    public TransferService transferService() {
        return new TransferService(accountRepository());
    }
}
```

以下示例显示了示例`system-test-config.xml`文件的一部分：
```
<beans>
    <!-- enable processing of annotations such as @Autowired and @Configuration -->
    <context:annotation-config/>
    <context:property-placeholder location="classpath:/com/acme/jdbc.properties"/>

    <bean class="com.acme.AppConfig"/>

    <bean class="org.springframework.jdbc.datasource.DriverManagerDataSource">
        <property name="url" value="${jdbc.url}"/>
        <property name="username" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>
    </bean>
</beans>
```
以下示例显示了可能的`jdbc.properties`文件：
```
jdbc.url=jdbc:hsqldb:hsql://localhost/xdb
jdbc.username=sa
jdbc.password=
```

```
public static void main(String[] args) {
    ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:/com/acme/system-test-config.xml");
    TransferService transferService = ctx.getBean(TransferService.class);
    // ...
}
```

> 在`system-test-config.xml`文件中，AppConfig `<bean />`不声明id元素。虽然这样做是可以接受的，但是没有必要，因为没有其他bean引用它，并且不太可能通过名称从容器中明确地获取它。
> 类似地，DataSource bean只是按类型自动装配，因此不严格要求显式的bean id。

###### 使用`<context：component-scan />`来获取`@Configuration`类
因为`@Configuration`是使用`@Component`进行元注释的，所以`@Configuration`-annotated类自动成为组件扫描的候选者。使用与前一个示例中描述的相同的方案，我们可以重新定义`system-test-config.xml`以利用组件扫描。
请注意，在这种情况下，我们不需要显式声明`<context：annotation-config />`，因为`<context：component-scan />`默认启用`<context：annotation-config />`。

以下示例显示了已修改的`system-test-config.xml`文件：
```
<beans>
    <!-- picks up and registers AppConfig as a bean definition -->
    <context:component-scan base-package="com.acme"/>
    <context:property-placeholder location="classpath:/com/acme/jdbc.properties"/>

    <bean class="org.springframework.jdbc.datasource.DriverManagerDataSource">
        <property name="url" value="${jdbc.url}"/>
        <property name="username" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>
    </bean>
</beans>
```

###### @Configuration以类为中心在@ImportResource中使用XML
在`@Configuration`类是配置容器的主要机制的应用程序中，仍然可能需要使用至少一些XML。在这些场景中，您可以使用`@ImportResource`并根据需要定义尽可能多的XML。
这样做可以实现“以Java为中心”的方法来配置容器并将XML保持在最低限度。
以下示例（包括配置类，定义bean的XML文件，属性文件和主类）显示了如何使用`@ImportResource`批注来实现根据需要使用XML的“以Java为中心”的配置：
```
@Configuration
@ImportResource("classpath:/com/acme/properties-config.xml")
public class AppConfig {

    @Value("${jdbc.url}")
    private String url;

    @Value("${jdbc.username}")
    private String username;

    @Value("${jdbc.password}")
    private String password;

    @Bean
    public DataSource dataSource() {
        return new DriverManagerDataSource(url, username, password);
    }
}
```
```
properties-config.xml
<beans>
    <context:property-placeholder location="classpath:/com/acme/jdbc.properties"/>
</beans>
```
```
jdbc.properties
jdbc.url=jdbc:hsqldb:hsql://localhost/xdb
jdbc.username=sa
jdbc.password=
```
```
public static void main(String[] args) {
    ApplicationContext ctx = new AnnotationConfigApplicationContext(AppConfig.class);
    TransferService transferService = ctx.getBean(TransferService.class);
    // ...
}
```

### 1.13 Environment Abstraction
`Environment`接口是集成在容器中的抽象，它模拟了应用程序环境的两个关键方面：配置文件和属性。

profile是仅在给定profile处于活动状态时才向容器注册的Bean定义的命名逻辑组（就是说只有这个porfile是激活状态的bean才会被注册进容器，可以控制bean定义的注册）。可以将Bean分配给配置文件，无论是以XML还是使用注释定义。
与配置文件相关的`Environment`对象的作用是确定哪些配置文件（如果有）当前处于活动状态，以及默认情况下哪些配置文件（如果有）应处于活动状态。

Properties在几乎所有应用程序中都起着重要作用，并且可能源自各种来源:
properties files, JVM system properties, system environment variables, JNDI, servlet context parameters, ad-hoc Properties objects, Map objects等等。
与properties相关的`Environment`对象的作用是为用户提供方便的服务接口，用于配置属性源和从中解析属性。

#### 1.13.1 Bean Definition Profiles
Bean定义配置文件在核心容器中提供了一种机制，允许在不同环境中注册不同的bean。“environment”这个词对不同的用户来说意味着不同的东西，这个功能可以帮助许多用例，包括：

* 在QA或生产环境中，针对开发中的内存数据源而不是从JNDI查找相同的数据源。
* 仅在将应用程序部署测试环境时注册监视基础结构。
* 为客户A和客户B部署注册bean的自定义实施。

考虑需要`DataSource`的实际应用程序中的第一个用例。在测试环境中，配置可能类似于以下内容：
```
@Bean
public DataSource dataSource() {
    return new EmbeddedDatabaseBuilder()
        .setType(EmbeddedDatabaseType.HSQL)
        .addScript("my-schema.sql")
        .addScript("my-test-data.sql")
        .build();
}
```
现在考虑如何将此应用程序部署到QA或生产环境中，假设应用程序的数据源已在生产应用程序服务器的JNDI目录中注册。bean现在看起来像下面的列表：
```
@Bean(destroyMethod="")
public DataSource dataSource() throws Exception {
    Context ctx = new InitialContext();
    return (DataSource) ctx.lookup("java:comp/env/jdbc/datasource");
}
```
问题是如何根据当前环境在使用这两种变体之间切换。随着时间的推移，Spring用户已经设计了许多方法来完成这项工作，
通常依赖于系统环境变量和包含$ {placeholder}标记的XML `<import />`语句的组合，这些标记根据环境变量的值解析为正确的配置文件路径。Bean定义配置文件是核心容器功能，可为此问题提供解决方案。

如果我们对前面的特定于环境的bean定义示例中显示的用例概括，我们最终需要在某些上下文中注册某些bean定义，而在其他上下文中则不需要。
您可以说您想在情境A中注册某个bean定义的配置文件，在情况B中注册不同的配置文件。我们首先更新配置以反映这种需求。

##### 使用 @Profile
`@Profile`注释允许您指示当一个或多个指定的配置文件处于活动状态时，组件符合注册条件。使用前面的示例，我们可以重写`dataSource`配置，如下所示：
```
@Configuration
@Profile("development")
public class StandaloneDataConfig {

    @Bean
    public DataSource dataSource() {
        return new EmbeddedDatabaseBuilder()
            .setType(EmbeddedDatabaseType.HSQL)
            .addScript("classpath:com/bank/config/sql/schema.sql")
            .addScript("classpath:com/bank/config/sql/test-data.sql")
            .build();
    }
}
```
```
@Configuration
@Profile("production")
public class JndiDataConfig {

    @Bean(destroyMethod="")
    public DataSource dataSource() throws Exception {
        Context ctx = new InitialContext();
        return (DataSource) ctx.lookup("java:comp/env/jdbc/datasource");
    }
}
```

> 如前所述，使用`@Bean`方法，您通常选择使用Spring的`JndiTemplate/JndiLocatorDelegate`帮助程序或前面显示的直接JNDI `InitialContext`用法，而不是`JndiObjectFactoryBean`变量，
> 这会强制您将返回类型声明为`FactoryBean`类型。

配置文件字符串可以包含简单的配置文件名称（例如，生产）或配置文件表达式。概要表达式允许表达更复杂的概要逻辑（例如，生产和us-east）。
配置文件表达式支持以下运算符：

* !: A logical “not” of the profile
* &: A logical “and” of the profiles
* |: A logical “or” of the profiles

> 你不能混合＆和|不使用括号的运算符。例如，生产＆us-east |欧洲中心不是一个有效的表达。它必须表示为生产和（us-east | eu-central）。

您可以使用`@Profile`作为元注释，以创建自定义组合注释。以下示例定义了一个自定义`@Production`批注，您可以将其用作`@Profile("production")`的替代品：
```
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Profile("production")
public @interface Production {
}
```

> 如果使用`@Profile`标记`@Configuration`类，则除非一个或多个指定的配置文件处于活动状态，否则将绕过与该类关联的所有`@Bean`方法和`@Import`注释。
> 如果使用@`@Profile({"p1", "p2"})`标记`@Component`或`@Configuration`类，则除非已激活配置文件“p1”或“p2”，否则不会注册或处理该类。
> 如果给定的配置文件以NOT运算符（`!`）作为前缀，则仅在配置文件未激活时才注册带注释的元素。
> 例如，给定`@Profile({"p1", "!p2"})`，如果配置文件“p1”处于活动状态或配置文件“p2”未激活，则会进行注册。

`@Profile`也可以在方法级别声明，以仅包含配置类的一个特定bean（例如，对于特定bean的替代变体），如以下示例所示：
```
@Configuration
public class AppConfig {

    @Bean("dataSource")
    @Profile("development") //standaloneDataSource方法仅在development环境下可用。 
    public DataSource standaloneDataSource() {
        return new EmbeddedDatabaseBuilder()
            .setType(EmbeddedDatabaseType.HSQL)
            .addScript("classpath:com/bank/config/sql/schema.sql")
            .addScript("classpath:com/bank/config/sql/test-data.sql")
            .build();
    }

    @Bean("dataSource")
    @Profile("production") //jndiDataSource方法仅在生产配置文件中可用。
    public DataSource jndiDataSource() throws Exception {
        Context ctx = new InitialContext();
        return (DataSource) ctx.lookup("java:comp/env/jdbc/datasource");
    }
}
```

> 对于`@Bean`方法的`@Profile`，可能会应用特殊方案：对于具有相同Java方法名称的重载`@Bean`方法（类似于构造函数重载），需要在所有重载方法上一致地声明`@Profile`条件。
> 如果条件不一致，则只有重载方法中第一个声明的条件才重要。因此，`@Profile`不能用于选择具有特定参数签名的重载方法。在创建时，Spring的构造函数解析算法遵循同一bean的所有工厂方法之间的分辨率。

##### XML Bean Definition Profiles
XML对应物是`<beans>`元素的`profile`属性。我们之前的示例配置可以在两个XML文件中重写，如下所示：
```
<beans profile="development"
    xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:jdbc="http://www.springframework.org/schema/jdbc"
    xsi:schemaLocation="...">

    <jdbc:embedded-database id="dataSource">
        <jdbc:script location="classpath:com/bank/config/sql/schema.sql"/>
        <jdbc:script location="classpath:com/bank/config/sql/test-data.sql"/>
    </jdbc:embedded-database>
</beans>
```
```
<beans profile="production"
    xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:jee="http://www.springframework.org/schema/jee"
    xsi:schemaLocation="...">

    <jee:jndi-lookup id="dataSource" jndi-name="java:comp/env/jdbc/datasource"/>
</beans>
```

也可以避免在同一文件中使用split和nest `<beans />`元素，如下例所示：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:jdbc="http://www.springframework.org/schema/jdbc"
    xmlns:jee="http://www.springframework.org/schema/jee"
    xsi:schemaLocation="...">

    <!-- other bean definitions -->

    <beans profile="development">
        <jdbc:embedded-database id="dataSource">
            <jdbc:script location="classpath:com/bank/config/sql/schema.sql"/>
            <jdbc:script location="classpath:com/bank/config/sql/test-data.sql"/>
        </jdbc:embedded-database>
    </beans>

    <beans profile="production">
        <jee:jndi-lookup id="dataSource" jndi-name="java:comp/env/jdbc/datasource"/>
    </beans>
</beans>
```
`spring-bean.xsd`已经被约束为仅允许这些元素作为文件中的最后一个元素。这应该有助于提供灵活性，而不会在XML文件中引起混乱。

> XML不支持前面描述的配置文件表达式。但是，有可能通过使用`!`来否定一个配置文件。也可以通过嵌套配置文件来应用逻辑“and”，如以下示例所示：
```
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:jdbc="http://www.springframework.org/schema/jdbc"
    xmlns:jee="http://www.springframework.org/schema/jee"
    xsi:schemaLocation="...">

    <!-- other bean definitions -->

    <beans profile="production">
        <beans profile="us-east">
            <jee:jndi-lookup id="dataSource" jndi-name="java:comp/env/jdbc/datasource"/>
        </beans>
    </beans>
</beans>
```
在前面的示例中，如果`production`和`us-east`配置文件都处于活动状态，则会公开`dataSource` bean。

##### 激活profile
现在我们已经更新了配置，我们仍然需要指示Spring哪个配置文件处于活动状态。
如果我们现在开始我们的示例应用程序，我们会看到抛出NoSuchBeanDefinitionException，因为容器找不到名为dataSource的Spring bean。

激活配置文件可以通过多种方式完成，但最直接的方法是以编程方式对可通过`ApplicationContext`提供的`Environment` API进行操作。
以下示例显示了如何执行此操作：

```
AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext();
ctx.getEnvironment().setActiveProfiles("development");
ctx.register(SomeConfig.class, StandaloneDataConfig.class, JndiDataConfig.class);
ctx.refresh();
```

此外，您还可以通过`spring.profiles.active`属性以声明方式激活配置文件，可以通过系统环境变量，JVM系统属性，`web.xml`中的servlet上下文参数或甚至作为JNDI中的条目来指定（参见[`PropertySource`](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/core.html#beans-property-source-abstraction) Abstraction）。
在集成测试中，可以使用spring-test模块中的@ActiveProfiles批注声明活动配置文件（请参阅[具有环境配置文件的上下文](https://docs.spring.io/spring/docs/5.1.6.RELEASE/spring-framework-reference/testing.html#testcontext-ctx-management-env-profiles)配置）。

请注意，配置文件不是“either-or”命题。您可以一次激活多个配置文件。以编程方式，您可以为`setActiveProfiles()`方法提供多个配置文件名称，该方法接受`String ... `varargs。以下示例激活多个配置文件：
```
ctx.getEnvironment().setActiveProfiles("profile1", "profile2");
```
声明性地，`spring.profiles.active`可以接受以逗号分隔的概要文件名列表，如以下示例所示：
```
-Dspring.profiles.active="profile1,profile2"
```

##### Default Profile
默认配置文件表示默认启用的配置文件。请考虑以下示例：
```
@Configuration
@Profile("default")
public class DefaultDataConfig {

    @Bean
    public DataSource dataSource() {
        return new EmbeddedDatabaseBuilder()
            .setType(EmbeddedDatabaseType.HSQL)
            .addScript("classpath:com/bank/config/sql/schema.sql")
            .build();
    }
}
```
如果没有激活配置文件，则创建dataSource。您可以将此视为一种为一个或多个bean提供默认定义的方法。如果启用了任何配置文件，则默认配置文件不适用。
您可以使用环境上的setDefaultProfiles（）或声明性地使用spring.profiles.default属性更改默认配置文件的名称。

#### 1.13.2 PropertySource Abstraction
Spring的Environment抽象通过可配置的属性源层次结构提供搜索操作。请考虑以下列表：
```
ApplicationContext ctx = new GenericApplicationContext();
Environment env = ctx.getEnvironment();
boolean containsMyProperty = env.containsProperty("my-property");
System.out.println("Does my environment contain the 'my-property' property? " + containsMyProperty);
```
在前面的代码片段中，我们看到了一种向Spring询问`my-property`属性是否为当前环境定义的高级方法。要回答此问题，`Environment`对象会对一组`PropertySource`对象执行搜索。
`PropertySourc`e是对任何键值对源的简单抽象，Spring的`StandardEnvironment`配置有两个PropertySource对象-- 一个表示JVM系统属性集（`System.getProperties()`），另一个表示系统环境变量集（`System.getenv()`）。

> 这些默认属性源存在于`StandardEnvironment中`，用于独立应用程序。`StandardServletEnvironment`使用其他默认属性源填充，包括servlet配置和servlet上下文参数。它可以选择启用`JndiPropertySource`。有关详细信息，请参阅javadoc。

具体地说，当您使用`StandardEnvironment`时，如果在运行时存在`my-property`系统属性或`my-property`环境变量，则对`env.containsProperty("my-property")`的调用将返回true。

> 执行的搜索是分层的。默认情况下，系统属性优先于环境变量。因此，如果在调用`env.getProperty（“my-property”）`期间碰巧在两个地方都设置了my-property属性，