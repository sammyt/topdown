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

  public class Extractor
  {
    public var action:Function;

    private var cache:Dictionary = new Dictionary();

    public function Extractor()
    {
    }

    public function bind(parser:IParser, name:String):IParser
    {
      return new BindParser(parser, cache, name);
    }

    public function extract(args:Object):Object
    {
      return action(cache);
    }
  }
}