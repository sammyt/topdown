/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 15:23
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public interface IParserBuilder
  {
    function range(start:String, end:String):IParser;

    function oneOrMore(parser:Object):IParser;

    function future(name:String):IParser;

    function choice(...args):IParser;

    function sequence(...args):IParser;

    function zeroOrMore(parser:Object):IParser;

    function satisfyFuture(name:String, parser:IParser):IParser;

    function terminal(chars:String):IParser;

    function toParser(obj:Object):IParser;

    function chose(...args):IParser;

    function re(regex:RegExp):IParser;

    function repSep(parser:Object, seperator:Object):IParser;

    function whitespace(parser:Object):IParser;
  }
}
