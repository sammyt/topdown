/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 12/12/2010
 * Time: 16:05
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import flash.utils.Dictionary;

  public class BindAction implements IParseAction
  {
    public var action:Function;
    private var cache:Dictionary = new Dictionary();
    private var bindings:Array;

    public function BindAction()
    {
      bindings = [];
    }

    public function bind(parser:IParser, name:Object):IParser
    {
      var bind:BindParser = new BindParser(parser, name);
      bindings.push(bind);
      refreshCache();
      return bind
    }

    public function extract():Object
    {
      if (action != null)
      {
        var result:Object = action(cache);
        refreshCache();
        return result;
      }
      return cache;
    }

    private function refreshCache():void
    {
      cache = new Dictionary();
      for each(var bind:BindParser in bindings)
      {
        bind.cache = cache;
      }
    }
  }
}